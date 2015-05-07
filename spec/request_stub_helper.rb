require 'json'

module RequestStubHelper

  def stub_api_request(organization, api_key, spec)
    stub_request(spec[:method], "https://#{organization}.reactio.jp#{spec[:path]}")
      .with(
        headers: {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
          'X-Api-Key' => api_key
        },
        body: Hash(spec[:body]).to_json
      )
  end
end
