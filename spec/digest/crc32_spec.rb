require 'spec_helper'

describe Digest::CRC32 do
  describe 'hexdigest' do
    describe 'with string' do
      let(:string) { 'Hello world' }
      let(:expected_digest) { '8bd69e52' }

      it 'calculates digest correctly' do
        expect(described_class.hexdigest(string)).to eq(expected_digest)
      end
    end

    describe 'with file' do
      let(:file) do
        File.expand_path('../../fixtures/test_file.txt', __FILE__)
      end
      let(:digest_object) { described_class.file(file) }
      let(:expected_digest) { 'f68830b0' }

      it 'calculates digest correctly' do
        expect(digest_object.hexdigest).to eq(expected_digest)
      end
    end
  end

  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end
end
