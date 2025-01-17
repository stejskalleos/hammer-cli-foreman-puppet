require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), 'apipie_resource_mock')

require 'hammer_cli_foreman_puppet/environment'

describe HammerCLIForemanPuppet::PuppetEnvironment do

  include CommandTestHelper

  context "ListCommand" do
    before do
      ResourceMocks.mock_action_call(:environments, :index, [])
    end

    let(:cmd) { HammerCLIForemanPuppet::PuppetEnvironment::ListCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "no arguments"
      it_should_accept_search_params
    end

    context "output" do
      let(:expected_record_count) { count_records(cmd.resource.call(:index)) }

      it_should_print_n_records
      it_should_print_column "Name"
      it_should_print_column "Id"
    end

  end


  context "InfoCommand" do

    let(:cmd) { HammerCLIForemanPuppet::PuppetEnvironment::InfoCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "id", ["--id=1"]
      it_should_accept "name", ["--name=env"]
      # it_should_fail_with "no arguments"
      # TODO: temporarily disabled, parameters are checked in the id resolver
    end

    context "output" do
      with_params ["--id=1"] do
        it_should_print_n_records 1
        it_should_print_column "Name"
        it_should_print_column "Id"
        it_should_print_column "Created at"
        it_should_print_column "Updated at"
      end
    end

  end


  context "CreateCommand" do

    let(:cmd) { HammerCLIForemanPuppet::PuppetEnvironment::CreateCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "name", ["--name=env"]
      # it_should_fail_with "name missing", []
      # TODO: temporarily disabled, parameters are checked by the api
    end

  end


  context "DeleteCommand" do

    let(:cmd) { HammerCLIForemanPuppet::PuppetEnvironment::DeleteCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "name", ["--name=env"]
      it_should_accept "id", ["--id=1"]
      # it_should_fail_with "name or id missing", [] # TODO: temporarily disabled, parameters are checked in the id resolver
    end

  end


  context "UpdateCommand" do

    let(:cmd) { HammerCLIForemanPuppet::PuppetEnvironment::UpdateCommand.new("", ctx) }

    context "parameters" do
      it_should_accept "name", ["--name=env", "--new-name=env2"]
      it_should_accept "id", ["--id=1", "--new-name=env2"]
      # it_should_fail_with "no params", [] # TODO: temporarily disabled, parameters are checked in the id resolver
      # it_should_fail_with "name or id missing", ["--new-name=env2"] # TODO: temporarily disabled, parameters are checked in the id resolver
    end

  end

  context "SCParamsCommand" do

    before :each do
      ResourceMocks.smart_class_parameters_index
    end

    let(:cmd) { HammerCLIForemanPuppet::PuppetEnvironment::SCParamsCommand.new("", ctx) }

    context "parameters" do
      it_should_fail_with "environment", ["--environment=env"]
      it_should_accept "puppet environment", ["--puppet-environment=env"]
      it_should_fail_with "environment-id", ["--environment-id=1"]
      it_should_accept "puppet-environment-id", ["--puppet-environment-id=1"]
      it_should_accept "puppet-environment", ["--puppet-environment=env"]
      it_should_accept "puppet-environment-id", ["--puppet-environment-id=1"]
      # it_should_fail_with "name or id missing", [] # TODO: temporarily disabled, parameters are checked in the id resolver
    end

  end

end
