require 'spec_helper'

RSpec.describe RTika::StringParser, type: :parser do
  let(:content) do
    "this is my very ... long ... string"
  end

  let(:html) do
    "<html><head><title>MYTITLE</title></head><body>#{content}</body></html>"
  end

  subject { described_class.new(html) }

  it 'parser returns content' do
    expect(subject.parse.content).to eq content
  end

  it 'parser returns metadata' do
    expect(subject.parse.metadata).not_to be_nil
  end
end
