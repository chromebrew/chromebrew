# runtime_var.rb: set runtime variables based on corresponding environment variables
require_relative './function.rb'

def setvar (hash = {})
  # setvar: set var_name (given) from environment variables if exist,
  # otherwise set var_name to default_value (given)
  #
  # Examples:
  #   setvar({ EXAMPLE: true }) # if env variable CREW_EXAMPLE is defined, 
  #                             # set $OPT[:EXAMPLE] to ENV['CREW_EXAMPLE'],
  #                             # otherwise set to the given default value (true)
  $OPT ||= Hash.new
  hash.each_pair do |name, default_value|
    # variable name must be passed in symbols
    env_value = ENV["CREW_#{name}"]
    value = ( valid?(env_value) )? default_value : env_value

    # add variable to $OPT hash
    $OPT[name] = value
    # for compatibility with existing packages
    eval "CREW_#{name} = #{value.inspect}"
  end
end

setvar ({
  CACHE_ENABLED: false,
  CONFLICTS_ONLY_ADVISORY: true,
  DISABLE_ENV_OPTIONS: false,
  FHS_NONCOMPLIANCE_ONLY_ADVISORY: true,
  LA_RENAME_ENABLED: true,
  NOT_COMPRESS: false,
  NOT_STRIP: false,
  NOT_SHRINK_ARCHIVE: false,
  NOT_USE_PIXZ: false,
  TESTING: false,
  TESTING_BRANCH: nil,
  TESTING_REPO: nil
})
