require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'POST #create' do
    it 'creates a new URL' do
      expect {
        post :create, params: { url: { original_url: 'https://example.com' } }
      }.to change(Url, :count).by(1)
    end

    it 'redirects to URL info page' do
      post :create, params: { url: { original_url: 'https://example.com' } }
      expect(response).to redirect_to(url_info_path(assigns(:url).slug))
    end
  end

  describe 'GET #info' do
    let(:url) { Url.create(original_url: 'https://example.com', slug: 'abc123') }

    it 'assigns the URL' do
      get :info, params: { slug: url.slug }
      expect(assigns(:url)).to eq(url)
    end

    it 'assigns the visits' do
      visit1 = Visit.create(url: url, ip_address: '127.0.0.1')
      visit2 = Visit.create(url: url, ip_address: '192.168.1.1')

      get :info, params: { slug: url.slug }
      expect(assigns(:visits)).to match_array([visit1, visit2])
    end

    it 'redirects to the root path for an invalid URL' do
      get :info, params: { slug: 'invalid' }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Invalid URL')
    end
  end
end
