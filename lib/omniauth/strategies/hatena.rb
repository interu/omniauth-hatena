# -*- coding: utf-8 -*-
require "omniauth/strategies/oauth"
require 'multi_json'

module OmniAuth
  module Strategies
    class Hatena < OmniAuth::Strategies::OAuth

      option :name, 'hatena'

      option :client_options, {

        # Temporary Credential Request URL
        :request_token_url => 'https://www.hatena.com/oauth/initiate', 

        # Token Request URL
        :access_token_url  => 'https://www.hatena.com/oauth/token',

        # Resource Owner Authorization URL (PC)
        :authorize_url     => 'https://www.hatena.ne.jp/oauth/authorize'
      }

      def request_phase
        request_options = {:scope => 'read_public'}
        request_options.merge!(options[:authorize_params])
        
        request_token = consumer.get_request_token({:oauth_callback => callback_url}, request_options)
        session['oauth'] ||= {}
        session['oauth'][name.to_s] = {
          'callback_confirmed' => request_token.callback_confirmed?,
          'request_token' => request_token.token,
          'request_secret' => request_token.secret
        }
        r = Rack::Response.new
        
        if request_token.callback_confirmed?
          r.redirect(request_token.authorize_url)
        else
          r.redirect(request_token.authorize_url(:oauth_callback => callback_url))
        end
        
        r.finish
      end      

      option :fields, [:nickname, :name]
      option :uid_field, :nickname

      # uid { access_token.params[:url_name]}
      uid { user_hash[:url_name] }

      info do
        { 
          :name     => user_hash[:display_name],
          :nickname => user_hash[:url_name],
          :image    => user_hash[:profile_image_url],
          :urls     => { 'Hatena' => 'http://www.hatena.ne.jp/' + user_hash['url_name'] }
        }
      end

      extra do
        { :user_hash => user_hash}
      end

      def user_hash
        url = 'http://n.hatena.com/applications/my.json'
        @user_hash ||= MultiJson.decode(access_token.get(url).body)
                                                         
        # raise @user_hash.to_yaml.to_s
      rescue => e
        raise e.to_s
      end

    end
 end
end
