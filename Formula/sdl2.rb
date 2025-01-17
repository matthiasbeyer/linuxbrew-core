class Sdl2 < Formula
  desc "Low-level access to audio, keyboard, mouse, joystick, and graphics"
  homepage "https://www.libsdl.org/"
  url "https://libsdl.org/release/SDL2-2.0.12.tar.gz"
  sha256 "349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863"

  bottle do
    cellar :any
    sha256 "f01b56251f8798f687fc536546a66e18688dc7c1189e83324951e5638ae33657" => :catalina
    sha256 "9e82713279fc1fb81059f1c1070e60ffa6e3f085adc604aaf889a10222a1a7cb" => :mojave
    sha256 "40682e8ed7520c51b598833fd0600b7a0a3c4d027d01ec1ea54a1f119a286b52" => :high_sierra
    sha256 "6210e2111bd46fffc5ff3d5c46cb8fb86f05183ba8935dd696def93ffe4358a0" => :x86_64_linux
  end

  head do
    url "https://hg.libsdl.org/SDL", :using => :hg

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  unless OS.mac?
    depends_on "pkg-config" => :build
    depends_on "linuxbrew/xorg/libice"
    depends_on "linuxbrew/xorg/libxcursor"
    depends_on "linuxbrew/xorg/libxscrnsaver"
    depends_on "linuxbrew/xorg/libxxf86vm"
    depends_on "linuxbrew/xorg/xinput"
    depends_on "pulseaudio"
  end

  def install
    # we have to do this because most build scripts assume that all SDL modules
    # are installed to the same prefix. Consequently SDL stuff cannot be
    # keg-only but I doubt that will be needed.
    inreplace %w[sdl2.pc.in sdl2-config.in], "@prefix@", HOMEBREW_PREFIX

    system "./autogen.sh" if build.head?

    if OS.mac?
      args = %W[--prefix=#{prefix} --without-x]
    else
      args = %W[--prefix=#{prefix} --with-x]
    end

    unless OS.mac?
      args += %w[
        --enable-pulseaudio
        --enable-pulseaudio-shared
        --enable-video-dummy
        --enable-video-opengl
        --enable-video-opengles
        --enable-video-x11
        --enable-video-x11-scrnsaver
        --enable-video-x11-xcursor
        --enable-video-x11-xinerama
        --enable-video-x11-xinput
        --enable-video-x11-xrandr
        --enable-video-x11-xshape
        --enable-x11-shared
      ]
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"sdl2-config", "--version"
  end
end
