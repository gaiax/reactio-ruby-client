require 'json'

module RequestStubHelper
  MIME_TYPE = 'application/json'.freeze

  def stub_api_request(organization, api_key, spec)
    params = {}
    params[:headers] = build_headers(api_key)
    params[:body] = spec[:body] if spec.key?(:body)

    stub_request(
      spec[:method],
      "https://#{organization}.reactio.jp#{spec[:path]}"
    ).with(params)
  end

  def build_headers(api_key)
    {
      'Accept' => MIME_TYPE,
      'Content-Type' => MIME_TYPE,
      'X-Api-Key' => api_key
    }
  end
end
