require 'formula'

class FlexSdk45 < Formula
  url 'http://fpdownload.adobe.com/pub/flex/sdk/builds/flex4.5/flex_sdk_4.5.0.20967_mpl.zip'
  homepage 'http://opensource.adobe.com/wiki/display/flexsdk/Flex+SDK'
  sha256 '4055e284d4b9256e82ad0117112b18f9a29f013c353281c2bc7678f23e9b0a78'

  def install
    libexec.install Dir['*']
  end

  def caveats; <<-EOS.undent
    To use the SDK you will need to:

    (a) add the bin folder to your $PATH:
      #{libexec}/bin

    (b) set $FLEX_HOME:
      export FLEX_HOME=#{libexec}

    (c) add the tasks jar to ANT:
      mkdir -p ~/.ant/lib
      ln -s #{libexec}/ant/lib/flexTasks.jar ~/.ant/lib
    EOS
  end
end
