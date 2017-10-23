require 'sinatra'
require 'redis'

set :bind, '0.0.0.0'
default_key = '1'
cache = Redis.new(host: 'redis', port: 6379, db: 0)
cache.set(default_key, 'one')

%i[get post].each do |m|
  send m, '/' do
    key = params.key?('key') ? params['key'] : default_key

    if request.post? && params['submit'] == 'save'
      cache.set(key, params['cache_value'])
    end

    value = cache.get(key)
    cache_value = value if value

    erb :index, locals: { key: key, cache_value: cache_value }
  end
end
