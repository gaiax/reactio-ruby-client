require 'json'

module RequestStubHelper

  def stub_api_request(organization, api_key, spec)
    params = {}
    params[:headers] = build_headers(api_key)
    params[:body] = spec[:body].to_json unless Hash(spec[:body]).empty?

    stub_request(
      spec[:method],
      "https://#{organization}.reactio.jp#{spec[:path]}"
    ).with(params)
  end

  def build_headers(api_key)
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Api-Key' => api_key
    }
  end
end
