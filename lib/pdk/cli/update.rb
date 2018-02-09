require 'pdk/cli/util'

module PDK::CLI
  @update_cmd = @base_cmd.define_command do
    name 'update'
    usage _('update [options]')
    summary _('Update a module that has been created by or converted for use by PDK.')

    flag nil, :noop, _('Do not update the module, just output what would be done.')
    flag nil, :force, _('Update the module automatically, with no prompts.')

    be_hidden

    run do |opts, _args, _cmd|
      require 'pdk/module/update'

      PDK::CLI::Util.ensure_in_module!(
        message:   _('`pdk update` can only be run from inside a valid module directory.'),
        log_level: :info,
      )

      if opts[:noop] && opts[:force]
        raise PDK::CLI::ExitWithError, _('You can not specify --noop and --force when updating a module')
      end

      PDK::Module::Update.invoke(opts)
    end
  end
end
