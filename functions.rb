class FunctionsX < Formula
  desc "Go version of the IronFunctions command-line tools"
  homepage "https://github.com/iron-io/functions"
  url "https://github.com/iron-io/functions/archive/0.2.62.tar.gz"
  sha256 "e39e67195afc61b4bce69d61aa1248be3e5980fa5adce432315021d98a093c7a"

  depends_on "go" => :build
  depends_on "dep" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/iron-io/functions"
    dir.install Dir["*"]
    cd dir/"fn" do
      system "make", "dep"
      system "go", "build", "-o", bin/"fn"
    end
  end

  test do
    system bin/"fn", "-help"
  end
end
