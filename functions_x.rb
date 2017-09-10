class FunctionsX < Formula
  desc "Go version of the IronFunctions command-line tools"
  homepage "https://github.com/iron-io/functions"
    
  stable do
    url "https://github.com/iron-io/functions/archive/0.2.62.tar.gz"
    sha256 "e39e67195afc61b4bce69d61aa1248be3e5980fa5adce432315021d98a093c7a"
    
    depends_on "go" => :build
    depends_on "dep" => :build
  end

  bottle do
    cellar :any_skip_relocation
#     sha256 "a243445511d08268bac87dc4ee042366e9cb7ea5ded3a011431150b06b4dc894" => :sierra
#     sha256 "0382a73bd8168bcc4dfefb7710e7d377f62e49e15b83aa6ded26284a51be63b8" => :el_capitan
#     sha256 "2525bf5e2917ccf70c17c920739aaac88353390ba7ad15068c3963d2c5838389" => :yosemite
  end

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
