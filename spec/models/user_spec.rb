require 'rails_helper'

RSpec.describe User, type: :model do

  subject {described_class.new(:first_name => 'Anna', :last_name => 'Kon', :email => 'anna@gmail.com', :password => "123", :password_confirmation => "123", :password_digest => "777")}

  describe 'Validations do' do

    it 'saves successfully when all four feilds are provided' do
      subject.valid?
      expect(subject.errors).to be_empty
    end

    it 'fails to save when email is empty' do
      subject.email = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when first name is empty' do
      subject.first_name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when last name is empty' do
      subject.last_name = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password is empty' do
      subject.password = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password_confirmation is empty' do
      subject.password_confirmation = nil
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password and password_confirmation do not match' do
      subject.password_confirmation = '456'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when email is not unique (not case sensitive)' do
      User.create(:first_name => 'Anna', :last_name => 'Kon', :email => 'anna@gmail.com', :password => "123", :password_confirmation => "123", :password_digest => "777")
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    it 'fails to save when password and password_confirmation is less than length 3' do
      subject.password = '12'
      subject.password_confirmation = '12'
      subject.valid?
      expect(subject.errors).not_to be_empty
    end

    describe '.authenticate_with_credentials' do
      it 'returns user if succesfully authenticated' do
        user = User.authenticate_with_credentials('anna@gmail.com', '123')
        expect(subject).eql? user
      end

      it 'returns nil if not successfully authenticated' do
        user = User.authenticate_with_credentials('anna@gmail.com', '111')
        expect(user).eql? nil
      end

      it 'authenticates if user type white space before and/or after email' do
        user = User.authenticate_with_credentials(' anna@gmail.com ', '123')
        expect(subject).eql? user
      end

      it 'authenticates if users type lower and/or upper case in email' do
        user = User.authenticate_with_credentials('AnNA@gMAiL.com', '123')
        expect(subject).eql? user
      end
    end
  end
end