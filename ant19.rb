require 'formula'

class Ant19 < Formula
  homepage 'http://ant.apache.org/'
  url 'http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.0-bin.tar.gz'
  sha256 'd79dd4961a508d41618c98c3f1871d6c1eb1372f70b79439ba9c0e8c3ddc7e5f'

  def install
    rm Dir['bin/*.{bat,cmd,dll,exe}']
    libexec.install Dir['*']

    bin.mkpath
    Dir["#{libexec}/bin/*"].each do |f|
      ln_s f, bin+File.basename(f)
    end
  end

  test do
    system "ant", "-version"
  end
end
