# frozen_string_literal: true

module BootstrapHelper
  def flash_css_variant(flash_type)
    case flash_type
    when 'alert' then 'alert-danger'
    when 'warning' then 'alert-warning'
    when 'notice' then 'alert-info'
    when 'success' then 'alert-success'
    when 'primary' then 'alert-primary'
    else 'bg-body border'
    end
  end

  def dark_mode?
    cookies[:darkMode] == '1'
  end

  def current_theme
    dark_mode? ? :dark : :light
  end

  def form_input_css_variant(resource:, attribute:)
    return '' if resource.errors.none?

    resource.errors[attribute].any? ? 'is-invalid' : 'is-valid'
  end
end
