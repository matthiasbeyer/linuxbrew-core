class Muchsync < Formula
  desc "Synchronize notmuch mail across machines"
  homepage "http://www.muchsync.org/"
  url "http://www.muchsync.org/src/muchsync-5.tar.gz"
  sha256 "d1f704b9a72395e43303de9b1f4d8e14dd27bf3646fdbb374bb3dbb7d150dc35"
  head "http://www.muchsync.org/muchsync.git", :using => :git

  bottle do
    cellar :any
    sha256 "7abcdbcd0cb0bb8769038d6d5071605fe3b30cf92a2cb02fe99b021ae3258a25" => :catalina
    sha256 "e8b7c72755336b60de167c3735347124141afa70e2bc5b67cc5d986a7ee6a459" => :mojave
    sha256 "0b3af768a7e46d41285220c422ef60c729353d45774b0af609c7e3260506b71b" => :high_sierra
  end

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gmime"
  depends_on "talloc"
  depends_on "xapian"
  depends_on "zlib"

  def install
    system "./configure", *args
    system "make", "V=1", "install"
  end
end

