require 'sinatra'

set :bind, '0.0.0.0'
default_key = '1'
cache = { default_key => 'one' }

%i[get post].each do |m|
  send m, '/' do
    key = params.key?('key') ? params['key'] : default_key

    if request.post? && params['submit'] == 'save'
      cache[key] = params['cache_value']
    end

    cache_value = cache[key] if cache.key? key

    erb :index, locals: { key: key, cache_value: cache_value }
  end
end
