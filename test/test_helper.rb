require "bundler/setup"

require "shrine/storage/google_cloud_storage"

require "dotenv"

require "forwardable"
require "stringio"

Dotenv.load!

class FakeIO
  def initialize(content)
    @io = StringIO.new(content)
  end

  extend Forwardable
  delegate [:read, :size, :close, :eof?, :rewind] => :@io
end

class Minitest::Test
  def fakeio(content = "file")
    FakeIO.new(content)
  end

  def image
    File.open("test/fixtures/image.jpg")
  end
end