cask 'bettertouchtool' do
  if MacOS.version <= :mavericks
    version '2.05'
    sha256 '41013cfeffee286a038363651db3dd315ff3a1e0cf07774d9ce852111be50a5a'

    # bettertouchtool.net/releases was verified as official when first introduced to the cask
    url "https://bettertouchtool.net/releases/btt#{version}_final_10_9.zip"
  else
    version '3.086'
    sha256 'c0813657084dfabc960615fe4653ad07bd90dcf74e20b26558321a7467f22728'

    # bettertouchtool.net/releases was verified as official when first introduced to the cask
    url "https://bettertouchtool.net/releases/btt#{version}.zip"
    appcast 'https://bettertouchtool.net/releases/'
  end

  name 'BetterTouchTool'
  homepage 'https://folivora.ai/'

  auto_updates true

  app 'BetterTouchTool.app'

  uninstall login_item: 'BetterTouchTool'

  zap trash: [
               '~/Library/Preferences/com.hegenberg.BetterTouchTool.plist',
               '~/Library/Application Support/BetterTouchTool',
             ]
end
