local Iam = { Name = 'John Johnson',  Email = '' }

return
  {
    What =
      {
        Name = 'YourLibbaName',
        Version = '1.0.0', -- Semver
        Category = 'Uncategorized',
        Description = 'First line of description.',
        Description_Continued = 'Second line of description.',
        MoreInfo_Url = 'https://url-for-more.info',
      },
    How =
      {
        ReadOnly = true,
        Architectures = { 'esp8266' },
        Dependencies =
          {
            { Name = '', VersionExpression = '' },
          },
      },
    Who =
      {
        Authors = { Iam },
        Maintainers = { Iam },
      },
  }
