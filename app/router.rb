class Router
    def self.draw(server)
        @server = server

        self.match('/', "Root page")
        self.match('/hello', "Hello page")
        self.match('/about', "About page")
    end
    
    def self.match(path, message)
        @server.mount_proc path do |req, res|
            res.body = message
        end
    end
end