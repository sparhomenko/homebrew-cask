class Cask::Download
  attr_reader :cask

  def initialize(cask)
    @cask = cask
  end

  def perform
    require 'software_spec'
    cask = @cask
    downloader = Cask::CurlDownloadStrategy.new(cask)
    downloaded_path = downloader.fetch

    _check_sums(downloaded_path, cask.sums) unless cask.sums === 0
    downloaded_path
  end

  private
  def _check_sums(path, sums)
    has_sum = false
    sums.each do |sum|
      unless sum.empty?
        computed = Checksum.new(sum.hash_type, Digest.const_get(sum.hash_type.to_s.upcase).file(path).hexdigest)
        if sum == computed
          odebug "Checksums match"
        else
          raise ChecksumMismatchError.new(sum, computed)
        end
        has_sum = true
      end
    end
    raise ChecksumMissingError.new("Checksum required. SHA-256: '#{Digest::SHA256.file(path).hexdigest}'") unless has_sum
  end
end
