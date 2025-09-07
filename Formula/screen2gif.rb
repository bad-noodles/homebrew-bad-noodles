class Screen2gif < Formula
  desc "MacOS command-line tool that records your screen and converts it to a GIF"
  homepage "https://github.com/bad-noodles/screen2gif"
  url "https://github.com/bad-noodles/screen2gif/archive/refs/tags/0.0.1.tar.gz"
  sha256 "8522f26bf19b4a541dd19e1b3092f3e021a8c709d2f05cd2f91ce6134a1e6e41"
  license "GPL-3.0-or-later"
  head "https://github.com/bad-noodles/screen2gif.git", branch: "main"

  depends_on "ffmpeg"
  depends_on :macos
  depends_on "bad-noodle/bad-noodle/keycastr-cli" => :optional

  def install
    # Install the main executable
    bin.install "screen2gif"

    # Install zsh completion file
    zsh_completion.install "_screen2gif"

    # Make sure the script is executable
    chmod 0755, bin/"screen2gif"
  end

  def caveats
    <<~EOS
      screen2gif - Record screen and convert to GIF

      Usage: screen2gif [OPTIONS] <filename>

      Arguments:
        filename          Output filename (without .gif extension)

      Options:
        -f, --fps FPS     Frames per second (default: 10)
        -s, --scale SIZE  Scale width in pixels (default: 1920)
        -r, --replace     Replace existing output file if it exists
        -k, --keycast     Enable keystroke capture overlay using keycastr-cli
        -h, --help        Show this help message

      Examples:
        screen2gif demo                    # demo.gif at 10fps, 1920px wide
        screen2gif -f 15 demo              # demo.gif at 15fps, 1920px wide
        screen2gif -f 15 -s 1080 demo      # demo.gif at 15fps, 1080px wide
        screen2gif --fps 20 --scale 720 demo  # demo.gif at 20fps, 720px wide
        screen2gif -r demo                 # Replace demo.gif if it exists
        screen2gif -k demo                 # Record with keystroke overlay
        screen2gif -k -f 15 -s 1080 demo   # Keystrokes + 15fps + 1080px wide

      Requirements for keystroke capture:
        1. Install KeyCastr: brew install --cask keycastr
        2. Install keycastr-cli: brew install bad-noodles/bad-noodles/keycastr-cli
    EOS
  end

  test do
    # Test help command works
    output = shell_output("#{bin}/screen2gif --help")
    assert_match "Usage: screen2gif", output
    assert_match "Examples:", output
  end
end
