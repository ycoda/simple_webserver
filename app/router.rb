class Router
    def self.draw(server)
        @server = server

        # HTMLの登録
        self.match('/', "index.html")
        self.match('/hello', "hello.html")
        self.match('/about', "about.html")
        # CSSの登録
        self.match('/style.css', 'style.css', 'text/css')
    end
    
    def self.match(path, filename, content_type = 'text/html')
        @server.mount_proc path do |req, res|
            folder = content_type == 'text/html' ? 'views' : 'public'
            file_path = File.join(folder, filename)

            if !File.exist?(file_path)
                self.render_404(res, content_path, filename)
                next
            end

            body = File.read(file_path)

            req.query.each do |key, value|
                safe_value = value.to_s.force_encoding('UTF-8')
                body.gsub!("{{#{key}}}", safe_value)
                res.body = body
                res['Content-Type'] = "#{content_type}; charset=utf-8"
            end
            def render_404(res, content_type, filename)
                res.status = 404
                res['Content-Type'] = "#{content_type}; charset=utf-8"
                res.body = "404 not found #{filename}が見つかりません"
            end
        end
    end
end