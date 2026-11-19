class Evado < Formula
  desc "Terminal client for Evado todos"
  homepage "https://evado.app"
  license "MIT"

  on_macos do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.1/evado_1.0.1_darwin_arm64.tar.gz"
      sha256 "583c773987785751c718fc797ea314c68de966c67708c6173ba9a6943b68e7ae"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.1/evado_1.0.1_darwin_amd64.tar.gz"
      sha256 "18191b2659eac0d59b24886040fe48e14a8c4def266a8995ac3713bd290f4c7b"
    end
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.1/evado_1.0.1_linux_arm64.tar.gz"
      sha256 "188cc8313a8f39d5d1115074cd3e6f4e6dd73abe5e5f21b5fccb60d9651afc68"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.1/evado_1.0.1_linux_amd64.tar.gz"
      sha256 "4b7d3ddcc842319bd2ce7c6e04f8759792687d6e90824b9789417cefbb362be4"
    end
  end

  def install
    bin.install "evado"
    pkgshare.install "THIRD_PARTY_NOTICES.txt"
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    assert_equal "evado #{version}", shell_output("#{bin}/evado -version").strip

    ENV["EVADO_CONFIG"] = (testpath/"profile/config.json").to_s
    added = JSON.parse(shell_output("#{bin}/evado -local add -json 'Homebrew formula test'"))
    todo = added.fetch("todos").fetch(0)
    assert_equal "Homebrew formula test", todo.fetch("title")

    listed = JSON.parse(shell_output("#{bin}/evado -local ls -json"))
    assert_equal [todo.fetch("id")], listed.fetch("todos").map { |item| item.fetch("id") }
  end
end
