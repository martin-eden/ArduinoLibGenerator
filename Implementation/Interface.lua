-- ArduinoLibGenerator API

-- Nothing to see here. Core code at "Internals/Compile.lua".

return
  {
    -- Configuration defaults
    ResultsDir = 'Data/',
    ConfigurationFilename = 'Configurations/Sample.lua',
    DoDecompile = false,
    -- Main
    Run = request('Run'),
    -- Help texts for CLI
    GetUsageText = request('GetUsageText'),
    GetConfigurationExample = request('GetConfigurationExample'),
  }
