class Consul
  class Kv
    def initialize(config)
      @host = config[:host]
      @port = config[:port].to_s
      @disable_raw = config[:disable_raw]
      @url = "http://" + @host + ":" + @port + "/v1/kv/"
      @http = ::HttpRequest.new()
    end
    #
    # req_method: get / put / delete(del)
    # args: key / value
    #
    def get(key, args={})
      @http.get(make_url(key, args))
    end

    def put(key, value, args={})
      @http.put(@url + key, value)
    end

    def del(key, args={})
      @http.delete(@url + key)
    end

    private
    def make_url(key, args)
      ret = @url + key
      query = @disable_raw ? "?" : "?raw&"
      args.each do |k, v|
        query << "#{k}=#{v}&"
      end
      ret << query.chop
    end
  end
end
