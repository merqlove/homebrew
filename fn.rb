class IronFunctionsCli < Formula
  desc "Go version of the Iron.io Functions command-line tools"
  homepage "https://iron.io"
  url "https://github.com/iron-io/functions/releases/download/0.2.62/fn_mac"
  sha256 "ba753fbaa4f9487c99f9fa5b870e8118ec2d8a558735ed3ce1144a19fda92460"

  bottle :unneeded

  def install
    bin.install "fn_mac"
    system "mv", "#{bin}/fn_mac", "#{bin}/fn"
  end
  
  test do
    system "#{bin}/fn", "-help"
  end
end
