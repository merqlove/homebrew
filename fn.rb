class Fn < Formula
  desc "IronFunctions command-line tools"
  homepage "https://iron.io"

  stable do
    url "https://github.com/iron-io/functions/releases/download/0.2.62/fn_mac"
    sha256 "ba753fbaa4f9487c99f9fa5b870e8118ec2d8a558735ed3ce1144a19fda92460"
    version "0.2.62-2"
  end

  bottle :unneeded

  def install
    libexec.install "fn_mac"
    bin.write_exec_script libexec/"fn_mac", "fn"
  end

  test do
    system "#{bin}/fn", "-help"
  end
end
