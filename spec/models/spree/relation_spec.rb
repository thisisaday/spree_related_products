require 'spec_helper'

describe Spree::Relation do
  context 'relations' do
    it { should belong_to(:relation_type) }
    it { should belong_to(:relatable) }
    it { should belong_to(:related_to) }
  end

  context 'validation' do
    it { should validate_presence_of(:relation_type) }
    it { should validate_presence_of(:relatable) }
    it { should validate_presence_of(:related_to) }
  end

  describe 'after create' do
    let!(:product) { create(:product) }
    let!(:related_product) { create(:product) }

    it 'touches the products', :aggregate_failures do
      expect(product).to receive(:touch)
      expect(related_product).to receive(:touch)

      Spree::Relation.create!(
        relation_type: create(:relation_type),
        relatable: product,
        related_to: related_product
      )
    end
  end
end
