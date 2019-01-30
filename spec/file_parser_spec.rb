require 'spec_helper'

RSpec.describe RTika::FileParser, type: :parser do
  subject { described_class.new(file.path.to_s, parser_opts) }

  context 'when pdf file with default tika config' do
    let(:file) { RbFiles::SampleFile.new }
    let(:parser_opts) { Hash.new }

    it 'parser returns content' do
      expect(subject.parse.content).to eq file.pages.join('')
    end

    context 'parser returns metadata' do
      let(:metadata) { subject.parse.metadata }

      it '#filename' do
        expect(metadata.get('filename')).to eq file.name
      end
    end
  end
end
