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
            
            if File.exist?(file_path)
                res.body = File.read(file_path)
                res['Content-Type'] = "#{content_type}; charset=utf-8"
            else
                res.status = 404
                res['Content-Type'] = "#{content_type}; charset=utf-8"
                res.body = "404 not found #{filename}が見つかりません"
            end
        end
    end
end