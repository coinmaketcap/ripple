# Copyright 2010 Sean Cribbs, Sonian Inc., and Basho Technologies, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems' # Use the gems path only for the spec suite
require 'ripple'
require 'spec'
require 'spec/autorun'
require 'fakeweb'

Dir[File.join(File.dirname(__FILE__), "support", "*.rb")].each {|f| require f }

$server = MockServer.new
at_exit { $server.stop }

Spec::Runner.configure do |config|
  config.before(:each) do
    FakeWeb.clean_registry
  end
end

def mock_response(overrides={})
  {:headers => {"content-type" => ["application/json"]}, :body => '{}'}.merge(overrides)
end