require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) {Category.new(:name => 'Clothing')}
  subject {described_class.new(:name => 'Dress', :price => 500, :quantity => 50, :category => category)}  

  describe 'Validations' do


    it 'saves successfully with all fields provided and belongs to a category' do
      subject.valid?
      expect(subject.errors).to be_empty
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end

    it 'fails to save when name is empty' do
      subject.name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when price is empty' do
      subject.price_cents = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when quantity is empty' do
      subject.quantity = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when category is empty' do
      subject.category = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end
  end  
end