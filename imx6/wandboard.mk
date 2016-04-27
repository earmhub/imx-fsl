# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

ifneq ($(wildcard device/fsl/wandboard/fstab_nand.freescale),)
$(shell touch device/fsl/wandboard/fstab_nand.freescale)
endif

ifneq ($(wildcard device/fsl/wandboard/fstab.freescale),)
$(shell touch device/fsl/wandboard/fstab.freescale)
endif

# Overrides
PRODUCT_NAME := wandboard
PRODUCT_DEVICE := wandboard

PRODUCT_PACKAGES += \
	libbt-vendor \

LIBBT_VENDORFILE	:= device/fsl/wandboard/brcm-firmware/libbt_vnd_wandboard.conf

PRODUCT_COPY_FILES += \
	device/fsl/wandboard/init.rc:root/init.freescale.rc \
        device/fsl/wandboard/init.i.MX6Q.rc:root/init.freescale.i.MX6Q.rc \
        device/fsl/wandboard/init.i.MX6DL.rc:root/init.freescale.i.MX6DL.rc \
	device/fsl/wandboard/init.i.MX6QP.rc:root/init.freescale.i.MX6QP.rc \
	device/fsl/wandboard/audio_policy.conf:system/etc/audio_policy.conf \
	device/fsl/wandboard/audio_effects.conf:system/vendor/etc/audio_effects.conf

PRODUCT_COPY_FILES +=	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6d.bin:system/lib/firmware/vpu/vpu_fw_imx6d.bin 	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6q.bin:system/lib/firmware/vpu/vpu_fw_imx6q.bin
# setup dm-verity configs.
ifneq ($(BUILD_TARGET_DEVICE),sd)
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk2p5
 $(call inherit-product, build/target/product/verity.mk)
else 
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk2p5
 $(call inherit-product, build/target/product/verity.mk)

endif

# wifi+bt files
PRODUCT_COPY_FILES += \
	device/fsl/wandboard/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
	device/fsl/wandboard/brcm-firmware/brcmfmac4330-sdio.bin:system/etc/firmware/brcm/brcmfmac4330-sdio.bin \
	device/fsl/wandboard/brcm-firmware/brcmfmac4330-sdio.txt:system/etc/firmware/brcm/brcmfmac4330-sdio.txt \
	device/fsl/wandboard/brcm-firmware/bcm4330.hcd:system/etc/firmware/brcm/bcm4330.hcd \
	device/fsl/wandboard/brcm-firmware/brcmfmac4329-sdio.bin:system/etc/firmware/brcm/brcmfmac4329-sdio.bin \
	device/fsl/wandboard/brcm-firmware/brcmfmac4329-sdio.txt:system/etc/firmware/brcm/brcmfmac4329-sdio.txt \
	device/fsl/wandboard/brcm-firmware/bcm4329.hcd:system/etc/firmware/brcm/bcm4329.hcd \
	device/fsl/wandboard/brcm-firmware/wifi_reset:system/bin/wifi_reset \
	device/fsl/wandboard/brcm-firmware/bt_reset:system/bin/bt_reset \
	device/fsl/wandboard/brcm-firmware/eth_updown:system/bin/eth_updown \
	device/fsl/wandboard/brcm-firmware/eth_flag:system/bin/eth_flag \
	device/fsl/wandboard/uenv/rc.control:system/bin/rc.control

# touch files
PRODUCT_COPY_FILES += \
	device/fsl/common/input/eGalax_Touch_Screen.idc:system/usr/idc/fusion_Touch_Screen.idc \
	device/fsl/common/input/eGalax_Touch_Screen.idc:system/usr/idc/ADS7846_Touchscreen.idc

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/fsl/wandboard/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi xhdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	device/fsl/wandboard/required_hardware.xml:system/etc/permissions/required_hardware.xml
PRODUCT_PACKAGES += AudioRoute
