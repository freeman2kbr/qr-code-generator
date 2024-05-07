require 'rmagick'
class PagesController < ApplicationController
  include Magick

  def qr_code_generator; end

  def qr_code_download
    send_data RQRCode::QRCode.new(params[:content].to_s).as_png(size: 300), type: 'image/png', disposition: 'inline' #attachment - para download
  end

  def qr_code_with_logo
    # now watermark with logo
    # magick composite -gravity center App_qr_icon_small.png li-source.png  final.png
    qrCodeFile = RQRCode::QRCode.new(params[:content].to_s).as_png(size: 300)
    IO.binwrite("qrcode.png", qrCodeFile.to_s)
    qrImage =  Image.read('qrcode.png')[0]
    logoImage = Image.read("logo.png")[0]
    finalImage = qrImage.composite(logoImage, CenterGravity, OverCompositeOp)
    finalImage.write('qrcode_with_logo.png')

    redirect_to :qr_code_generator
  end
end