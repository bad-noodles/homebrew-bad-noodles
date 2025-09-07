class KeycastrCli < Formula
  desc "Command-line interface for controlling KeyCastr keystroke visualizer"
  homepage "https://github.com/bad-noodles/keycastr-cli"
  url "https://github.com/bad-noodles/keycastr-cli/archive/refs/tags/0.0.1.tar.gz"
  sha256 "c492b7ba5a17d464fbc717e0a7fcb8fe1b13f094d1a1306a87ecf52a8e4a0b53"
  license "GPL-3.0-or-later"
  head "https://github.com/bad-noodles/keycastr-cli.git", branch: "main"

  # Only works on macOS due to AppleScript dependency
  depends_on :macos

  def install
    # Install the main executable
    bin.install "keycastr-cli"

    # Install zsh completion file
    zsh_completion.install "_keycastr-cli"

    # Make sure the script is executable
    chmod 0755, bin/"keycastr-cli"
  end

  def caveats
    <<~EOS
      KeyCastr CLI requires KeyCastr to be installed and running.

      Install KeyCastr:
        brew install --cask keycastr

      Usage examples:
        # Toggle capture state (default behavior)
        keycastr-cli
        keycastr-cli toggle

        # Check current status
        keycastr-cli status

        # Start capturing (if not already active)
        keycastr-cli start

        # Stop capturing (if currently active)
        keycastr-cli stop

        # Open KeyCastr application
        keycastr-cli open

        # Close KeyCastr application
        keycastr-cli close

        # Check if KeyCastr is running
        keycastr-cli running

        # Show help
        keycastr-cli help
    EOS
  end

  test do
    # Test help command works
    output = shell_output("#{bin}/keycastr-cli help")
    assert_match "Usage: keycastr-cli", output
    assert_match "Commands:", output

    # Test that invalid command shows error
    assert_match "Error: Unknown command", shell_output("#{bin}/keycastr-cli invalid 2>&1", 1)
  end
end
