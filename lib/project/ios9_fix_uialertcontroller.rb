class UIAlertController

    def supportedInterfaceOrientations
      rmq.device.landscape? ? UIInterfaceOrientationMaskLandscape : UIInterfaceOrientationMaskPortrait
      #  UIInterfaceOrientationMaskLandscape
    end

    def shouldAutorotate
        true
    end
end