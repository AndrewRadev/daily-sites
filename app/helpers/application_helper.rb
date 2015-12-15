module ApplicationHelper
  def andrews_email
    [
      'andrey',
      image_tag('emaildot.png', :width => 4, :height => 11),
      'radev',
      image_tag('emailat.png', :width => 7, :height => 11),
      'gmail',
      image_tag('emaildot.png', :width => 4, :height => 11),
      'com',
    ].join('').html_safe
  end

  def favicon(site)
    image_tag "#{site.url_root}/favicon.ico", {
      alt:   '',
      title: site.title,
      size:  '16x16',
      class: 'favicon'
    }
  end
end
