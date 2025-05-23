# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require 'spec_helper'

describe Elastic::Transport::Client do
  let(:client) do
    described_class.new.tap do |_client|
      allow(_client).to receive(:__build_connections)
    end
  end

  it 'has a default transport' do
    expect(client.transport).to be_a(Elastic::Transport::Client::DEFAULT_TRANSPORT_CLASS)
  end

  it 'preserves the Faraday default user agent header' do
    expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/Faraday/)
  end

  it 'identifies the Ruby client in the User-Agent header' do
    expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/elastic-transport-ruby\/#{Elastic::Transport::VERSION}/)
  end

  it 'identifies the Ruby version in the User-Agent header' do
    expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/#{RUBY_VERSION}/)
  end

  it 'identifies the host_os in the User-Agent header' do
    expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/#{RbConfig::CONFIG['host_os'].split('_').first[/[a-z]+/i].downcase}/)
  end

  it 'identifies the target_cpu in the User-Agent header' do
    expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/#{RbConfig::CONFIG['target_cpu']}/)
  end

  it 'sets the \'Content-Type\' header to \'application/json\' by default' do
    expect(client.transport.connections.first.connection.headers['Content-Type']).to eq('application/json')
  end

  it 'uses localhost by default' do
    expect(client.transport.hosts[0][:host]).to eq('localhost')
  end

  context 'when a User-Agent header is specified as client option' do
    let(:client) do
      described_class.new(transport_options: { headers: { 'User-Agent' => 'testing' } })
    end

    it 'sets the specified User-Agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to eq('testing')
    end
  end

  context 'when a user-agent header is specified as client option in lower-case' do

    let(:client) do
      described_class.new(transport_options: { headers: { 'user-agent' => 'testing' } })
    end

    it 'sets the specified User-Agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to eq('testing')
    end
  end

  context 'when a Content-Type header is specified as client option' do

    let(:client) do
      described_class.new(transport_options: { headers: { 'Content-Type' => 'testing' } })
    end

    it 'sets the specified Content-Type header' do
      expect(client.transport.connections.first.connection.headers['Content-Type']).to eq('testing')
    end
  end

  context 'when a content-type header is specified as client option in lower-case' do

    let(:client) do
      described_class.new(transport_options: { headers: { 'content-type' => 'testing' } })
    end

    it 'sets the specified Content-Type header' do
      expect(client.transport.connections.first.connection.headers['Content-Type']).to eq('testing')
    end
  end

  context 'when the Curb transport class is used', unless: jruby? do

    let(:client) do
      described_class.new(transport_class: Elastic::Transport::Transport::HTTP::Curb)
    end

    it 'preserves the Curb default user agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/Curb/)
    end

    it 'identifies the Ruby client in the User-Agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/elastic-transport-ruby\/#{Elastic::Transport::VERSION}/)
    end

    it 'identifies the Ruby version in the User-Agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/#{RUBY_VERSION}/)
    end

    it 'identifies the host_os in the User-Agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/#{RbConfig::CONFIG['host_os'].split('_').first[/[a-z]+/i].downcase}/)
    end

    it 'identifies the target_cpu in the User-Agent header' do
      expect(client.transport.connections.first.connection.headers['User-Agent']).to match(/#{RbConfig::CONFIG['target_cpu']}/)
    end

    it 'sets the \'Content-Type\' header to \'application/json\' by default' do
      expect(client.transport.connections.first.connection.headers['Content-Type']).to eq('application/json')
    end

    it 'uses localhost by default' do
      expect(client.transport.hosts[0][:host]).to eq('localhost')
    end

    context 'when a User-Agent header is specified as a client option' do

      let(:client) do
        described_class.new(transport_class: Elastic::Transport::Transport::HTTP::Curb,
                            transport_options: { headers: { 'User-Agent' => 'testing' } })
      end

      it 'sets the specified User-Agent header' do
        expect(client.transport.connections.first.connection.headers['User-Agent']).to eq('testing')
      end
    end

    context 'when a user-agent header is specified as a client option as lower-case' do

      let(:client) do
        described_class.new(transport_class: Elastic::Transport::Transport::HTTP::Curb,
                            transport_options: { headers: { 'user-agent' => 'testing' } })
      end

      it 'sets the specified User-Agent header' do
        expect(client.transport.connections.first.connection.headers['User-Agent']).to eq('testing')
      end
    end

    context 'when a Content-Type header is specified as client option' do

      let(:client) do
        described_class.new(transport_class: Elastic::Transport::Transport::HTTP::Curb,
                            transport_options: { headers: { 'Content-Type' => 'testing' } })
      end

      it 'sets the specified Content-Type header' do
        expect(client.transport.connections.first.connection.headers['Content-Type']).to eq('testing')
      end
    end

    context 'when a content-type header is specified as client option in lower-case' do

      let(:client) do
        described_class.new(transport_class: Elastic::Transport::Transport::HTTP::Curb,
                            transport_options: { headers: { 'content-type' => 'testing' } })
      end

      it 'sets the specified Content-Type header' do
        expect(client.transport.connections.first.connection.headers['Content-Type']).to eq('testing')
      end
    end
  end

  describe 'adapter' do
    context 'when no adapter is specified' do
      fork do
        let(:client) { described_class.new }
        let(:adapter) { client.transport.connections.all.first.connection.builder.adapter }

        it 'uses Faraday NetHttp' do
          expect(adapter).to eq Faraday::Adapter::NetHttp
        end
      end
    end unless jruby?

    context 'when the adapter is patron' do
      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      let(:client) do
        described_class.new(adapter: :patron, enable_meta_header: false)
      end

      it 'uses Faraday with the adapter' do
        require 'faraday/patron'
        expect(adapter).to eq Faraday::Adapter::Patron
      end
    end unless jruby?

    context 'when the adapter is typhoeus' do
      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      let(:client) do
        require 'faraday/typhoeus' if is_faraday_v2?

        described_class.new(adapter: :typhoeus, enable_meta_header: false)
      end

      it 'uses Faraday with the adapter' do
        expect(adapter).to eq Faraday::Adapter::Typhoeus
      end
    end unless jruby?

    context 'when the adapter is excon' do
      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      let(:client) do
        require 'faraday/excon'

        described_class.new(adapter: :excon, enable_meta_header: false)
      end

      it 'uses Faraday with the adapter' do
        expect(adapter).to eq Faraday::Adapter::Excon
      end
    end if is_faraday_v2?

    context 'when the adapter is async-http' do
      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      let(:client) do
        require 'async/http/faraday'

        described_class.new(adapter: :async_http, enable_meta_header: false)
      end

      it 'uses Faraday with the adapter' do
        expect(adapter).to eq Async::HTTP::Faraday::Adapter
      end
    end unless jruby? || !is_faraday_v2?

    context 'when the adapter is specified as a string key' do
      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      let(:client) do
        described_class.new(adapter: :patron, enable_meta_header: false)
      end

      it 'uses Faraday with the adapter' do
        expect(adapter).to eq Faraday::Adapter::Patron
      end
    end unless jruby?

    context 'when the adapter can be detected', unless: jruby? do
      around do |example|
        require 'patron'; load 'patron.rb'
        example.run
      end

      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      it 'uses the detected adapter' do
        expect(adapter).to eq Faraday::Adapter::Patron
      end
    end

    context 'when the Faraday adapter is configured' do
      let(:client) do
        described_class.new do |faraday|
          faraday.adapter :patron
          faraday.response :logger
        end
      end

      let(:adapter) do
        client.transport.connections.all.first.connection.builder.adapter
      end

      let(:handlers) do
        client.transport.connections.all.first.connection.builder.handlers
      end

      it 'sets the adapter' do
        expect(adapter).to eq Faraday::Adapter::Patron
      end

      it 'sets the logger' do
        expect(handlers).to include(Faraday::Response::Logger)
      end
    end unless jruby?
  end

  shared_examples_for 'a client that extracts hosts' do
    context 'when the host is a String' do
      context 'when there is a protocol specified' do
        context 'when credentials are specified \'http://USERNAME:PASSWORD@myhost:8080\'' do
          let(:host) do
            'http://USERNAME:PASSWORD@myhost:8080'
          end

          it 'extracts the credentials' do
            expect(hosts[0][:user]).to eq('USERNAME')
            expect(hosts[0][:password]).to eq('PASSWORD')
          end

          it 'extracts the host' do
            expect(hosts[0][:host]).to eq('myhost')
          end

          it 'extracts the port' do
            expect(hosts[0][:port]).to be(8080)
          end
        end

        context 'when there is a trailing slash \'http://myhost/\'' do
          let(:host) do
            'http://myhost/'
          end

          it 'extracts the host' do
            expect(hosts[0][:host]).to eq('myhost')
            expect(hosts[0][:scheme]).to eq('http')
            expect(hosts[0][:path]).to eq('')
          end

          it 'extracts the scheme' do
            expect(hosts[0][:scheme]).to eq('http')
          end

          it 'extracts the path' do
            expect(hosts[0][:path]).to eq('')
          end
        end

        context 'when there is a trailing slash with a path \'http://myhost/foo/bar/\'' do
          let(:host) do
            'http://myhost/foo/bar/'
          end

          it 'extracts the host' do
            expect(hosts[0][:host]).to eq('myhost')
            expect(hosts[0][:scheme]).to eq('http')
            expect(hosts[0][:path]).to eq('/foo/bar')
          end
        end

        context 'when the protocol is http' do
          context 'when there is no port specified \'http://myhost\'' do
            let(:host) do
              'http://myhost'
            end

            it 'extracts the host' do
              expect(hosts[0][:host]).to eq('myhost')
            end

            it 'extracts the protocol' do
              expect(hosts[0][:protocol]).to eq('http')
            end

            it 'defaults to port 9200' do
              expect(hosts[0][:port]).to be(9200)
            end
          end

          context 'when there is a port specified \'http://myhost:7101\'' do

            let(:host) do
              'http://myhost:7101'
            end

            it 'extracts the host' do
              expect(hosts[0][:host]).to eq('myhost')
            end

            it 'extracts the protocol' do
              expect(hosts[0][:protocol]).to eq('http')
            end

            it 'extracts the port' do
              expect(hosts[0][:port]).to be(7101)
            end

            context 'when there is a path specified \'http://myhost:7101/api\'' do

              let(:host) do
                'http://myhost:7101/api'
              end

              it 'sets the path' do
                expect(hosts[0][:host]).to eq('myhost')
                expect(hosts[0][:protocol]).to eq('http')
                expect(hosts[0][:path]).to eq('/api')
                expect(hosts[0][:port]).to be(7101)
              end

              it 'extracts the host' do
                expect(hosts[0][:host]).to eq('myhost')
              end

              it 'extracts the protocol' do
                expect(hosts[0][:protocol]).to eq('http')
              end

              it 'extracts the port' do
                expect(hosts[0][:port]).to be(7101)
              end

              it 'extracts the path' do
                expect(hosts[0][:path]).to eq('/api')
              end
            end
          end
        end

        context 'when the protocol is https' do

          context 'when there is no port specified \'https://myhost\'' do

            let(:host) do
              'https://myhost'
            end

            it 'extracts the host' do
              expect(hosts[0][:host]).to eq('myhost')
            end

            it 'extracts the protocol' do
              expect(hosts[0][:protocol]).to eq('https')
            end

            it 'defaults to port 443' do
              expect(hosts[0][:port]).to be(443)
            end
          end

          context 'when there is a port specified \'https://myhost:7101\'' do

            let(:host) do
              'https://myhost:7101'
            end

            it 'extracts the host' do
              expect(hosts[0][:host]).to eq('myhost')
            end

            it 'extracts the protocol' do
              expect(hosts[0][:protocol]).to eq('https')
            end

            it 'extracts the port' do
              expect(hosts[0][:port]).to be(7101)
            end

            context 'when there is a path specified \'https://myhost:7101/api\'' do

              let(:host) do
                'https://myhost:7101/api'
              end

              it 'extracts the host' do
                expect(hosts[0][:host]).to eq('myhost')
              end

              it 'extracts the protocol' do
                expect(hosts[0][:protocol]).to eq('https')
              end

              it 'extracts the port' do
                expect(hosts[0][:port]).to be(7101)
              end

              it 'extracts the path' do
                expect(hosts[0][:path]).to eq('/api')
              end
            end
          end

          context 'when IPv6 format is used' do

            around do |example|
              original_setting = Faraday.ignore_env_proxy
              Faraday.ignore_env_proxy = true
              example.run
              Faraday.ignore_env_proxy = original_setting
            end

            let(:host) do
              'https://[2090:db8:85a3:9811::1f]:8080'
            end

            it 'extracts the host' do
              expect(hosts[0][:host]).to eq('[2090:db8:85a3:9811::1f]')
            end

            it 'extracts the protocol' do
              expect(hosts[0][:protocol]).to eq('https')
            end

            it 'extracts the port' do
              expect(hosts[0][:port]).to be(8080)
            end

            it 'creates the correct full url' do
              expect(client.transport.__full_url(client.transport.hosts[0])).to eq('https://[2090:db8:85a3:9811::1f]:8080')
            end
          end
        end
      end

      context 'when no protocol is specified \'myhost\'' do

        let(:host) do
          'myhost'
        end

        it 'defaults to http' do
          expect(hosts[0][:host]).to eq('myhost')
          expect(hosts[0][:protocol]).to eq('http')
        end

        it 'uses port 9200' do
          expect(hosts[0][:port]).to be(9200)
        end
      end
    end

    context 'when the host is a Hash' do

      let(:host) do
        { :host => 'myhost', :scheme => 'https' }
      end

      it 'extracts the host' do
        expect(hosts[0][:host]).to eq('myhost')
      end

      it 'extracts the protocol' do
        expect(hosts[0][:protocol]).to eq('https')
      end

      it 'extracts the port' do
        expect(hosts[0][:port]).to be(9200)
      end

      context 'when IPv6 format is used' do

        around do |example|
          original_setting = Faraday.ignore_env_proxy
          Faraday.ignore_env_proxy = true
          example.run
          Faraday.ignore_env_proxy = original_setting
        end

        let(:host) do
          { host: '[2090:db8:85a3:9811::1f]', scheme: 'https', port: '443' }
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('[2090:db8:85a3:9811::1f]')
          expect(hosts[0][:scheme]).to eq('https')
          expect(hosts[0][:port]).to be(443)
        end

        it 'creates the correct full url' do
          expect(client.transport.__full_url(client.transport.hosts[0])).to eq('https://[2090:db8:85a3:9811::1f]:443')
        end
      end

      context 'when the host is localhost as a IPv6 address' do

        around do |example|
          original_setting = Faraday.ignore_env_proxy
          Faraday.ignore_env_proxy = true
          example.run
          Faraday.ignore_env_proxy = original_setting
        end

        let(:host) do
          { host: '[::1]' }
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('[::1]')
          expect(hosts[0][:port]).to be(9200)
        end

        it 'creates the correct full url' do
          expect(client.transport.__full_url(client.transport.hosts[0])).to eq('http://[::1]:9200')
        end
      end

      context 'when the port is specified as a String' do

        let(:host) do
          { host: 'myhost', scheme: 'https', port: '443' }
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('https')
        end

        it 'converts the port to an integer' do
          expect(hosts[0][:port]).to be(443)
        end
      end

      context 'when the port is specified as an Integer' do

        let(:host) do
          { host: 'myhost', scheme: 'https', port: 443 }
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('https')
        end

        it 'extracts port as an integer' do
          expect(hosts[0][:port]).to be(443)
        end
      end
    end

    context 'when the hosts are a Hashie:Mash' do

      let(:host) do
        Hashie::Mash.new(host: 'myhost', scheme: 'https')
      end

      it 'extracts the host' do
        expect(hosts[0][:host]).to eq('myhost')
      end

      it 'extracts the protocol' do
        expect(hosts[0][:scheme]).to eq('https')
      end

      it 'converts the port to an integer' do
        expect(hosts[0][:port]).to be(9200)
      end

      context 'when the port is specified as a String' do

        let(:host) do
          Hashie::Mash.new(host: 'myhost', scheme: 'https', port: '443')
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('https')
        end

        it 'converts the port to an integer' do
          expect(hosts[0][:port]).to be(443)
        end
      end

      context 'when the port is specified as an Integer' do

        let(:host) do
          Hashie::Mash.new(host: 'myhost', scheme: 'https', port: 443)
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('https')
        end

        it 'extracts port as an integer' do
          expect(hosts[0][:port]).to be(443)
        end
      end
    end

    context 'when the hosts are an array' do

      context 'when there is one host' do

        let(:host) do
          ['myhost']
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:protocol]).to eq('http')
        end

        it 'defaults to port 9200' do
          expect(hosts[0][:port]).to be(9200)
        end
      end

      context 'when there is one host with a protocol and no port' do

        let(:host) do
          ['http://myhost']
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('http')
        end

        it 'defaults to port 9200' do
          expect(hosts[0][:port]).to be(9200)
        end
      end

      context 'when there is one host with a protocol and the default http port explicitly provided' do
        let(:host) do
          ['http://myhost:80']
        end

        it 'respects the explicit port' do
          expect(hosts[0][:port]).to be(80)
        end
      end

      context 'when there is one host with a protocol and the default https port explicitly provided' do
        let(:host) do
          ['https://myhost:443']
        end

        it 'respects the explicit port' do
          expect(hosts[0][:port]).to be(443)
        end
      end

      context 'when there is one host with a protocol and no port' do
        let(:host) do
          ['https://myhost']
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('https')
        end

        it 'defaults to port 443' do
          expect(hosts[0][:port]).to be(443)
        end
      end

      context 'when there is one host with a protocol, path, and no port' do
        let(:host) do
          ['http://myhost/foo/bar']
        end

        it 'extracts the host' do
          expect(hosts[0][:host]).to eq('myhost')
        end

        it 'extracts the protocol' do
          expect(hosts[0][:scheme]).to eq('http')
        end

        it 'defaults to port 9200' do
          expect(hosts[0][:port]).to be(9200)
        end

        it 'extracts the path' do
          expect(hosts[0][:path]).to eq('/foo/bar')
        end
      end

      context 'when there is more than one host' do
        let(:host) do
          ['host1', 'host2']
        end

        it 'extracts the hosts' do
          expect(hosts[0][:host]).to eq('host1')
          expect(hosts[0][:protocol]).to eq('http')
          expect(hosts[0][:port]).to be(9200)
          expect(hosts[1][:host]).to eq('host2')
          expect(hosts[1][:protocol]).to eq('http')
          expect(hosts[1][:port]).to be(9200)
        end
      end

      context 'when ports are also specified' do
        let(:host) do
          ['host1:1000', 'host2:2000']
        end

        it 'extracts the hosts' do
          expect(hosts[0][:host]).to eq('host1')
          expect(hosts[0][:protocol]).to eq('http')
          expect(hosts[0][:port]).to be(1000)
          expect(hosts[1][:host]).to eq('host2')
          expect(hosts[1][:protocol]).to eq('http')
          expect(hosts[1][:port]).to be(2000)
        end
      end
    end

    context 'when the hosts is an instance of URI' do
      let(:host) do
        URI.parse('https://USERNAME:PASSWORD@myhost:4430')
      end

      it 'extracts the host' do
        expect(hosts[0][:host]).to eq('myhost')
        expect(hosts[0][:scheme]).to eq('https')
        expect(hosts[0][:port]).to be(4430)
        expect(hosts[0][:user]).to eq('USERNAME')
        expect(hosts[0][:password]).to eq('PASSWORD')
      end
    end

    context 'when the hosts is invalid' do
      let(:host) do
        123
      end

      it 'extracts the host' do
        expect {
          hosts
        }.to raise_exception(ArgumentError)
      end
    end
  end

  context 'when hosts are specified with the \'host\' key' do
    let(:client) do
      described_class.new(host: ['host1', 'host2', 'host3', 'host4'], randomize_hosts: true)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it 'sets the hosts in random order' do
      expect(hosts.all? { |host| client.transport.hosts.include?(host) }).to be(true)
    end
  end

  context 'when hosts are specified with the \'host\' key as a String' do
    let(:client) do
      described_class.new('host' => ['host1', 'host2', 'host3', 'host4'], 'randomize_hosts' => true)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it 'sets the hosts in random order' do
      expect(hosts.all? { |host| client.transport.hosts.include?(host) }).to be(true)
    end
  end

  context 'when hosts are specified with the \'hosts\' key' do
    let(:client) do
      described_class.new(hosts: host)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it_behaves_like 'a client that extracts hosts'
  end

  context 'when hosts are specified with the \'hosts\' key as a String' do
    let(:client) do
      described_class.new('hosts' => host)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it_behaves_like 'a client that extracts hosts'
  end

  context 'when hosts are specified with the \'url\' key' do
    let(:client) do
      described_class.new(url: host)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it_behaves_like 'a client that extracts hosts'
  end

  context 'when hosts are specified with the \'url\' key as a String' do
    let(:client) do
      described_class.new('url' => host)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it_behaves_like 'a client that extracts hosts'
  end

  context 'when hosts are specified with the \'urls\' key' do
    let(:client) do
      described_class.new(urls: host)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it_behaves_like 'a client that extracts hosts'
  end

  context 'when hosts are specified with the \'urls\' key as a String' do
    let(:client) do
      described_class.new('urls' => host)
    end

    let(:hosts) do
      client.transport.hosts
    end

    it_behaves_like 'a client that extracts hosts'
  end

  context 'when the URL is set in the ELASTICSEARCH_URL environment variable' do
    context 'when there is only one host specified' do
      around do |example|
        before_url = ENV['ELASTICSEARCH_URL']
        ENV['ELASTICSEARCH_URL'] = 'example.com'
        example.run
        ENV['ELASTICSEARCH_URL'] = before_url
      end

      it 'sets the host' do
        expect(client.transport.hosts[0][:host]).to eq('example.com')
        expect(client.transport.hosts.size).to eq(1)
      end
    end

    context 'when mutliple hosts are specified as a comma-separated String list' do
      around do |example|
        before_url = ENV['ELASTICSEARCH_URL']
        ENV['ELASTICSEARCH_URL'] = 'example.com, other.com'
        example.run
        ENV['ELASTICSEARCH_URL'] = before_url
      end

      it 'sets the hosts' do
        expect(client.transport.hosts[0][:host]).to eq('example.com')
        expect(client.transport.hosts[1][:host]).to eq('other.com')
        expect(client.transport.hosts.size).to eq(2)
      end
    end
  end

  context 'when options are defined' do

    context 'when scheme is specified' do

      let(:client) do
        described_class.new(scheme: 'https')
      end

      it 'sets the scheme' do
        expect(client.transport.connections[0].full_url('')).to match(/https/)
      end
    end

    context 'when scheme is specified as a String key' do

      let(:client) do
        described_class.new('scheme' => 'https')
      end

      it 'sets the scheme' do
        expect(client.transport.connections[0].full_url('')).to match(/https/)
      end
    end

    context 'when user and password are specified' do

      let(:client) do
        described_class.new(user: 'USERNAME', password: 'PASSWORD')
      end

      it 'sets the user and password' do
        expect(client.transport.connections[0].full_url('')).to match(/USERNAME/)
        expect(client.transport.connections[0].full_url('')).to match(/PASSWORD/)
      end

      context 'when the connections are reloaded' do

        before do
          allow(client.transport.sniffer).to receive(:hosts).and_return([{ host: 'foobar', port: 4567, id: 'foobar4567' }])
          client.transport.reload_connections!
        end

        it 'sets keeps user and password' do
          expect(client.transport.connections[0].full_url('')).to match(/USERNAME/)
          expect(client.transport.connections[0].full_url('')).to match(/PASSWORD/)
          expect(client.transport.connections[0].full_url('')).to match(/foobar/)
        end
      end
    end

    context 'when user and password are specified as String keys' do

      let(:client) do
        described_class.new('user' => 'USERNAME', 'password' => 'PASSWORD')
      end

      it 'sets the user and password' do
        expect(client.transport.connections[0].full_url('')).to match(/USERNAME/)
        expect(client.transport.connections[0].full_url('')).to match(/PASSWORD/)
      end

      context 'when the connections are reloaded' do

        before do
          allow(client.transport.sniffer).to receive(:hosts).and_return([{ host: 'foobar', port: 4567, id: 'foobar4567' }])
          client.transport.reload_connections!
        end

        it 'sets keeps user and password' do
          expect(client.transport.connections[0].full_url('')).to match(/USERNAME/)
          expect(client.transport.connections[0].full_url('')).to match(/PASSWORD/)
          expect(client.transport.connections[0].full_url('')).to match(/foobar/)
        end
      end
    end

    context 'when port is specified' do

      let(:client) do
        described_class.new(host: 'node1', port: 1234)
      end

      it 'sets the port' do
        expect(client.transport.connections[0].full_url('')).to match(/1234/)
      end
    end

    context 'when the log option is true' do

      let(:client) do
        described_class.new(log: true)
      end

      it 'has a default logger for transport' do
        expect(client.transport.logger.info).to eq(described_class::DEFAULT_LOGGER.call.info)
      end
    end

    context 'when the trace option is true' do

      let(:client) do
        described_class.new(trace: true)
      end

      it 'has a default logger for transport' do
        expect(client.transport.tracer.info).to eq(described_class::DEFAULT_TRACER.call.info)
      end
    end

    context 'when a custom transport class is specified' do

      let(:transport_class) do
        Class.new { def initialize(*); end }
      end

      let(:client) do
        described_class.new(transport_class: transport_class)
      end

      it 'allows the custom transport class to be defined' do
        expect(client.transport).to be_a(transport_class)
      end
    end

    context 'when a custom transport instance is specified' do

      let(:transport_instance) do
        Class.new { def initialize(*); end }.new
      end

      let(:client) do
        described_class.new(transport: transport_instance)
      end

      it 'allows the custom transport class to be defined' do
        expect(client.transport).to be(transport_instance)
      end
    end

    context 'when \'transport_options\' are defined' do

      let(:client) do
        described_class.new(transport_options: { request: { timeout: 1 } })
      end

      it 'sets the options on the transport' do
        expect(client.transport.options[:transport_options][:request]).to eq(timeout: 1)
      end
    end

    context 'when \'request_timeout\' is defined' do

      let(:client) do
        described_class.new(request_timeout: 120)
      end

      it 'sets the options on the transport' do
        expect(client.transport.options[:transport_options][:request]).to eq(timeout: 120)
      end
    end

    context 'when \'request_timeout\' is defined as a String key' do

      let(:client) do
        described_class.new('request_timeout' => 120)
      end

      it 'sets the options on the transport' do
        expect(client.transport.options[:transport_options][:request]).to eq(timeout: 120)
      end
    end
  end

  describe '#perform_request' do

    let(:transport_instance) do
      Class.new { def initialize(*); end }.new
    end

    let(:client) do
      described_class.new(transport: transport_instance)
    end

    it 'delegates performing requests to the transport' do
      expect(transport_instance).to receive(:perform_request).and_return(true)
      expect(client.perform_request('GET', '/')).to be(true)
    end

    context 'when the \'send_get_body_as\' option is specified' do

      let(:client) do
        described_class.new(transport: transport_instance, :send_get_body_as => 'POST')
      end

      before do
        expect(transport_instance).to receive(:perform_request).with('POST', '/', {},
                                                                     '{"foo":"bar"}',
                                                                     '{"Content-Type":"application/x-ndjson"}').and_return(true)
      end

      let(:request) do
        client.perform_request('POST', '/', {}, '{"foo":"bar"}', '{"Content-Type":"application/x-ndjson"}')
      end

      it 'sets the option' do
        expect(request).to be(true)
      end
    end

    context 'when Elasticsearch response includes a warning header' do
      let(:logger) { double('logger', warn: '', warn?: '', info?: '', info: '', debug?: '', debug: '') }
      let(:client) do
        Elastic::Transport::Client.new(hosts: hosts, logger: logger)
      end

      let(:warning) { 'Elasticsearch warning: "deprecation warning"' }

      it 'prints a warning' do
        expect_any_instance_of(Faraday::Connection).to receive(:run_request) do
          Elastic::Transport::Transport::Response.new(200, {}, { 'warning' => warning })
        end
        client.perform_request('GET', '/')
        expect(logger).to have_received(:warn).with(warning)
      end
    end

    context 'when Elasticsearch response includes long precision Float' do
      let(:client) do
        Elastic::Transport::Client.new(hosts: hosts)
      end
      before do
        expect_any_instance_of(Faraday::Connection).to receive(:run_request) do
          Elastic::Transport::Transport::Response.new(200, "{\"score\":1.11111111111111111}", { 'content-type' => 'application/json; charset=UTF-8' })
        end
      end

      context 'when default JSON engine is used' do
        after do
          # Clear MultiJson's adapter
          ::MultiJson.instance_variable_set(:@adapter, nil)
        end
        it 'returns as a Float' do
          response = client.perform_request('GET', '/')
          score = response.body['score']
          expect(score).to eq 1.11111111111111111
          expect(score.class).to eq Float
        end
      end

      unless defined?(JRUBY_VERSION)
        context 'when Oj is used as a JSON engine' do
          before do
            require 'oj'
          end
          after do
            # Clear MultiJson's adapter
            ::MultiJson.instance_variable_set(:@adapter, nil)
          end

          it 'returns as a Float' do
            response = client.perform_request('GET', '/')
            score = response.body['score']
            expect(score).to eq 1.11111111111111111
            expect(score.class).to eq Float
          end
        end
      end
    end
  end

  context 'when the client connects to Elasticsearch' do
    let(:logger) do
      Logger.new($stderr) unless ENV['QUIET']
    end

    let(:port) do
      TEST_PORT
    end

    let(:transport_options) do
      {}
    end

    let(:options) do
      {}
    end

    let(:client) do
      described_class.new({ host: hosts, logger: logger }.merge!(transport_options: transport_options).merge!(options))
    end

    context 'when a request is made' do
      let!(:response) do
        client.perform_request('GET', '_cluster/health')
      end

      it 'connects to the cluster' do
        expect(response.body['number_of_nodes']).to be >= (1)
      end
    end

    describe '#initialize' do
      context 'when options are specified' do
        let(:transport_options) do
          { headers: { accept: 'application/yaml', content_type: 'application/yaml' } }
        end

        let(:response) do
          client.perform_request('GET', '_cluster/health')
        end

        it 'applies the options to the client' do
          expect(response.body).to match(/---\n/)
          expect(response.headers['content-type']).to eq('application/yaml')
        end
      end

      context 'when a block is provided' do
        let(:client) do
          Elastic::Transport::Client.new(host: ELASTICSEARCH_HOSTS.first, logger: logger) do |client|
            client.headers['Accept'] = 'application/yaml'
          end
        end

        let(:response) do
          client.perform_request('GET', '_cluster/health')
        end

        it 'executes the block' do
          expect(response.body).to match(/---\n/)
          expect(response.headers['content-type']).to eq('application/yaml')
        end

        context 'when the Faraday adapter is set in the block' do
          require 'faraday/net_http_persistent' if is_faraday_v2?

          let(:client) do
            Elastic::Transport::Client.new(host: ELASTICSEARCH_HOSTS.first, logger: logger) do |client|
              client.adapter(:net_http_persistent)
            end
          end

          let(:handler_name) do
            client.transport.connections.first.connection.builder.adapter.name
          end

          let(:response) do
            client.perform_request('GET', '_cluster/health')
          end

          it 'sets the adapter' do
            expect(handler_name).to eq('Faraday::Adapter::NetHttpPersistent')
          end

          it 'uses the adapter to connect' do
            expect(response.status).to eq(200)
          end
        end
      end
    end

    describe '#options' do
      context 'when retry_on_failure is true' do
        context 'when a node is unreachable' do
          let(:hosts) do
            [ELASTICSEARCH_HOSTS.first, "foobar1", "foobar2"]
          end

          let(:options) do
            { retry_on_failure: true }
          end

          let(:responses) do
            5.times.collect do
              client.perform_request('GET', '_nodes/_local')
            end
          end

          it 'retries on failure' do
            expect(responses.all? { true }).to be(true)
          end
        end
      end

      context 'when retry_on_failure is an integer' do
        let(:hosts) do
          [ELASTICSEARCH_HOSTS.first, 'foobar1', 'foobar2', 'foobar3']
        end

        let(:options) do
          { retry_on_failure: 1 }
        end

        it 'retries only the specified number of times' do
          expect(client.perform_request('GET', '_nodes/_local'))
          expect do
            client.perform_request('GET', '_nodes/_local')
          end.to raise_exception(Elastic::Transport::Transport::Error)
        end
      end

      context 'when retry_on_failure is true and delay_on_retry is specified' do
        context 'when a node is unreachable' do
          let(:hosts) do
            [ELASTICSEARCH_HOSTS.first, "foobar1", "foobar2"]
          end

          let(:options) do
            { retry_on_failure: true, delay_on_retry: 3000 }
          end

          let(:responses) do
            5.times.collect do
              client.perform_request('GET', '_nodes/_local')
            end
          end

          it 'retries on failure' do
            allow_any_instance_of(Object).to receive(:sleep).with(3000 / 1000)
            expect(responses.all? { true }).to be(true)
          end
        end
      end

      context 'when reload_on_failure is true' do
        let(:hosts) do
          [ELASTICSEARCH_HOSTS.first, 'foobar1', 'foobar2']
        end

        let(:options) do
          { reload_on_failure: true }
        end

        let(:responses) do
          5.times.collect do
            client.perform_request('GET', '_nodes/_local')
          end
        end

        it 'reloads the connections' do
          expect(client.transport.connections.size).to eq(3)
          expect(responses.all? { true }).to be(true)
          expect(client.transport.connections.size).to be >= (1)
        end
      end

      context 'when retry_on_status is specified' do
        let(:options) do
          { retry_on_status: 400 }
        end

        let(:logger) do
          double('logger', :debug? => false, :warn? => true, :fatal? => false, :error? => false)
        end

        before do
          expect(logger).to receive(:warn).exactly(4).times
        end

        it 'retries when the status matches' do
          expect {
            client.perform_request('PUT', '_foobar')
          }.to raise_exception(Elastic::Transport::Transport::Errors::BadRequest)
        end
      end

      context 'when the \'compression\' option is set to true' do
        context 'when using Faraday as the transport' do
          context 'when using the Net::HTTP adapter' do
            let(:client) do
              described_class.new(hosts: ELASTICSEARCH_HOSTS, compression: true, adapter: :net_http)
            end

            it 'compresses the request and decompresses the response' do
              expect(client.perform_request('GET', '/').body).to be_a(Hash)
            end

            it 'sets the Accept-Encoding header' do
              expect(client.transport.connections[0].connection.headers['Accept-Encoding']).to eq 'gzip'
            end

            it 'preserves the other headers' do
              expect(client.transport.connections[0].connection.headers['User-Agent'])
            end
          end

          context 'when using the HTTPClient adapter' do
            require 'faraday/httpclient'
            require 'mutex_m' if RUBY_VERSION >= '3.4'

            let(:client) do
              described_class.new(hosts: ELASTICSEARCH_HOSTS, compression: true, adapter: :httpclient, enable_meta_header: false)
            end

            it 'compresses the request and decompresses the response' do
              expect(client.perform_request('GET', '/').body).to be_a(Hash)
            end

            it 'sets the Accept-Encoding header' do
              expect(client.transport.connections[0].connection.headers['Accept-Encoding']).to eq 'gzip'
            end

            it 'preserves the other headers' do
              expect(client.transport.connections[0].connection.headers['User-Agent'])
            end
          end

          context 'when using the Patron adapter', unless: jruby? do
            let(:client) do
              described_class.new(hosts: ELASTICSEARCH_HOSTS, compression: true, adapter: :patron)
            end

            it 'compresses the request and decompresses the response' do
              expect(client.perform_request('GET', '/').body).to be_a(Hash)
            end

            it 'sets the Accept-Encoding header' do
              expect(client.transport.connections[0].connection.headers['Accept-Encoding']).to eq 'gzip'
            end

            it 'preserves the other headers' do
              expect(client.transport.connections[0].connection.headers['User-Agent'])
            end
          end

          context 'when using the Net::HTTP::Persistent adapter' do
            let(:client) do
              described_class.new(hosts: ELASTICSEARCH_HOSTS, compression: true, adapter: :net_http_persistent)
            end

            it 'compresses the request and decompresses the response' do
              expect(client.perform_request('GET', '/').body).to be_a(Hash)
            end

            it 'sets the Accept-Encoding header' do
              expect(client.transport.connections[0].connection.headers['Accept-Encoding']).to eq 'gzip'
            end

            it 'preserves the other headers' do
              expect(client.transport.connections[0].connection.headers['User-Agent'])
            end
          end

          context 'when using the Typhoeus adapter' do
            let(:client) do
              described_class.new(hosts: ELASTICSEARCH_HOSTS, compression: true, adapter: :typhoeus)
            end

            it 'compresses the request and decompresses the response' do
              expect(client.perform_request('GET', '/').body).to be_a(Hash)
            end

            it 'sets the Accept-Encoding header' do
              expect(client.transport.connections[0].connection.headers['Accept-Encoding']).to eq 'gzip'
            end

            it 'preserves the other headers' do
              expect(client.transport.connections[0].connection.headers['User-Agent'])
            end
          end unless jruby?
        end
      end

      context 'when using Curb as the transport', unless: jruby? do
        let(:client) do
          described_class.new(hosts: ELASTICSEARCH_HOSTS,
                              compression: true,
                              transport_class: Elastic::Transport::Transport::HTTP::Curb)
        end

        it 'compresses the request and decompresses the response' do
          expect(client.perform_request('GET', '/').body).to be_a(Hash)
        end

        it 'sets the Accept-Encoding header' do
          expect(client.transport.connections[0].connection.headers['Accept-Encoding']).to eq 'gzip'
        end

        it 'preserves the other headers' do
          expect(client.transport.connections[0].connection.headers['User-Agent'])
        end
      end

      context 'when using Manticore as the transport', if: jruby? do
        let(:client) do
          described_class.new(hosts: ELASTICSEARCH_HOSTS,
                              compression: true,
                              transport_class: Elastic::Transport::Transport::HTTP::Manticore)
        end

        it 'compresses the request and decompresses the response' do
          expect(client.perform_request('GET', '/').body).to be_a(Hash)
        end
      end
    end

    describe '#perform_request' do
      context 'when a request is made' do
        before do
          client.perform_request('DELETE', '_all')
          client.perform_request('DELETE', 'myindex') rescue
          client.perform_request('PUT', 'myindex', {}, { settings: { number_of_shards: 2, number_of_replicas: 0 } })
          client.perform_request('PUT', 'myindex/_doc/1', { routing: 'XYZ', timeout: '1s' }, { foo: 'bar' })
          client.perform_request('GET', '_cluster/health?wait_for_status=green&timeout=2s', {})
        end

        let(:response) do
          client.perform_request('GET', 'myindex/_doc/1?routing=XYZ')
        end

        it 'handles paths and URL paramters' do
          expect(response.status).to eq(200)
        end

        it 'returns response body' do
          expect(response.body['_source']).to eq('foo' => 'bar')
        end
      end

      context 'when an invalid url is specified' do
        it 'raises an exception' do
          expect {
            client.perform_request('GET', 'myindex/_doc/1?routing=FOOBARBAZ')
          }.to raise_exception(Elastic::Transport::Transport::Errors::NotFound)
        end
      end

      context 'when the \'ignore\' parameter is specified' do

        let(:response) do
          client.perform_request('PUT', '_foobar', ignore: 400)
        end

        it 'exposes the status in the response' do
          expect(response.status).to eq(400)
        end

        it 'exposes the body of the response' do
          expect(response.body).to be_a(Hash)
          expect(response.body.inspect).to match(/invalid_index_name_exception/)
        end
      end

      context 'when request headers are specified' do

        let(:response) do
          client.perform_request('GET', '/', {}, nil, { 'Content-Type' => 'application/yaml' })
        end

        it 'passes them to the transport' do
          expect(response.body).to match(/---/)
        end
      end

      describe 'selector' do

        context 'when the round-robin selector is used' do

          let(:nodes) do
            3.times.collect do
              client.perform_request('GET', '_nodes/_local').body['nodes'].to_a[0][1]['name']
            end
          end

          let(:node_names) do
            client.nodes.stats['nodes'].collect do |name, stats|
              stats['name']
            end
          end

          let(:expected_names) do
            3.times.collect do |i|
              node_names[i % node_names.size]
            end
          end

          # it 'rotates nodes' do
          #   pending 'Better way to detect rotating nodes'
          #   expect(nodes).to eq(expected_names)
          # end
        end
      end

      context 'when patron is used as an adapter', unless: jruby? do
        before do
          require 'patron'
        end

        let(:options) do
          { adapter: :patron }
        end

        let(:adapter) do
          client.transport.connections.first.connection.builder.adapter
        end

        it 'uses the patron connection handler' do
          expect(adapter).to eq('Faraday::Adapter::Patron')
        end

        it 'keeps connections open' do
          response = client.perform_request('GET', '_nodes/stats/http')
          connections_before = response.body['nodes'].values.find { |n| n['name'] == node_names.first }['http']['total_opened']
          client.transport.reload_connections!
          response = client.perform_request('GET', '_nodes/stats/http')
          connections_after = response.body['nodes'].values.find { |n| n['name'] == node_names.first }['http']['total_opened']
          expect(connections_after).to be >= (connections_before)
        end
      end

      context 'when typhoeus is used as an adapter', unless: jruby? do
        before do
          require 'typhoeus'
        end

        let(:options) do
          { adapter: :typhoeus }
        end

        let(:adapter) do
          client.transport.connections.first.connection.builder.adapter
        end

        it 'uses the patron connection handler' do
          expect(adapter).to eq('Faraday::Adapter::Typhoeus')
        end

        it 'keeps connections open' do
          response = client.perform_request('GET', '_nodes/stats/http')
          connections_before = response.body['nodes'].values.find { |n| n['name'] == node_names.first }['http']['total_opened']
          client.transport.reload_connections!
          response = client.perform_request('GET', '_nodes/stats/http')
          connections_after = response.body['nodes'].values.find { |n| n['name'] == node_names.first }['http']['total_opened']
          expect(connections_after).to be >= (connections_before)
        end
      end
    end
  end

  context 'CA Fingerprinting' do
    context 'when setting a ca_fingerprint' do
      let(:certificate) do
        system(
          'openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=BE/O=Test/CN=Test"' \
          ' -keyout certificate.key -out certificate.crt',
          err: File::NULL
        )
        OpenSSL::X509::Certificate.new File.read('./certificate.crt')
      end

      let(:client) do
        Elastic::Transport::Client.new(
          host: 'https://elastic:changeme@localhost:9200',
          ca_fingerprint: OpenSSL::Digest::SHA256.hexdigest(certificate.to_der)
        )
      end

      it 'validates CA fingerprints on perform request' do
        expect(client.transport.connections.connections.map(&:verified).uniq).to eq [false]
        allow(client.transport).to receive(:perform_request) { 'Hello' }

        server = double('server').as_null_object
        allow(TCPSocket).to receive(:new) { server }
        socket = double('socket')
        allow(OpenSSL::SSL::SSLSocket).to receive(:new) { socket }
        allow(socket).to receive(:connect) { nil }
        allow(socket).to receive(:peer_cert_chain) { [certificate] }

        response = client.perform_request('GET', '/')
        expect(client.transport.connections.connections.map(&:verified).uniq).to eq [true]
        expect(response).to eq 'Hello'
      end
    end

    context 'when using an http host' do
      let(:client) do
        Elastic::Transport::Client.new(
          host: 'http://elastic:changeme@localhost:9200',
          ca_fingerprint: 'test'
        )
      end

      it 'raises an error' do
        expect do
          client.perform_request('GET', '/')
        end.to raise_exception(Elastic::Transport::Transport::Error)
      end
    end

    context 'when not setting a ca_fingerprint' do
      let(:client) do
        Elastic::Transport::Client.new(
          host: 'http://elastic:changeme@localhost:9200'
        )
      end

      it 'has unvalidated connections' do
        allow(client).to receive(:validate_ca_fingerprints) { nil }
        allow(client.transport).to receive(:perform_request) { nil }

        client.perform_request('GET', '/')
        expect(client).to_not have_received(:validate_ca_fingerprints)
      end
    end
  end
end
