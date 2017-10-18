cask 'medis' do
  version '0.6.4'
  sha256 '9c0116604f523e1405d0671c38887302375d4d5a64387f2875468c6b5a594317'

  # github.com/luin/medis was verified as official when first introduced to the cask
  url "https://github.com/merqlove/medis/releases/download/v#{version}/medis-v#{version}-mac-x64.zip"
  appcast 'https://github.com/luin/medis/releases.atom',
          checkpoint: '63c631bd571035f4159f54701aaff0136d402c99218bbaea497bf4a58c1d576a'
  name 'Medis'
  homepage 'http://getmedis.com/'

  app 'Medis.app'
end
