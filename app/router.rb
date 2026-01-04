class Router
    def self.draw(server)
        @server = server

        self.match('/', "index.html")
        self.match('/hello', "hello.html")
        self.match('/about', "about.html")
    end
    
    def self.match(path, filename)
        @server.mount_proc path do |req, res|
            file_path = File.join('views', filename)
            
            
            if File.exist?(file_path)
                res.body = File.read(file_path)
                res['Content-Type'] = 'text/html; charset=utf-8'
            else
                res.status = 404
                res['Content-Type'] = 'text/html; charset=utf-8'
                res.body = "404 not found #{filename}が見つかりません"
            end
        end
    end
end