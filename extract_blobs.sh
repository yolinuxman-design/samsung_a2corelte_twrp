#!/bin/bash
# extract_blobs.sh - Helper script to pull required blobs from stock firmware
# Place your stock firmware extracted system/ and vendor/ directories in the same folder as this script

STOCK_SYSTEM="./stock_system"
STOCK_VENDOR="./stock_vendor"
DEST="./recovery/root"

if [ ! -d "$STOCK_SYSTEM" ] || [ ! -d "$STOCK_VENDOR" ]; then
    echo "Error: Create 'stock_system' and 'stock_vendor' folders with extracted firmware first!"
    echo "You can extract them using:"
    echo "  sdat2img system.transfer.list system.new.dat system.img"
    echo "  mkdir stock_system && mount -o loop system.img stock_system"
    exit 1
fi

echo "=== Extracting system blobs ==="
cp "$STOCK_SYSTEM/bin/storaged"                    "$DEST/system/bin/" 2>/dev/null || echo "WARN: storaged missing"
cp "$STOCK_SYSTEM/bin/uncrypt"                     "$DEST/system/bin/" 2>/dev/null || echo "WARN: uncrypt missing"
cp "$STOCK_SYSTEM/bin/vdc"                         "$DEST/system/bin/" 2>/dev/null || echo "WARN: vdc missing"
cp "$STOCK_SYSTEM/bin/vold"                        "$DEST/system/bin/" 2>/dev/null || echo "WARN: vold missing"

cp "$STOCK_SYSTEM/lib/ld-android.so"               "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/libdiskconfig.so"            "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/libf2fs_sparseblock.so"      "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/libsec_ode_integirty.so"     "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/libsec_ode_keymanager.so"    "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/libsec_ode_pbkdf.so"         "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/libsec_ode_sdcardencryption.so" "$DEST/system/lib/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/hw/keystore.default.so"      "$DEST/system/lib/hw/" 2>/dev/null
cp "$STOCK_SYSTEM/lib/hw/keystore.exynos7870.so"   "$DEST/system/lib/hw/" 2>/dev/null

cp "$STOCK_SYSTEM/etc/event-log-tags"              "$DEST/system/etc/" 2>/dev/null
cp "$STOCK_SYSTEM/etc/mke2fs.conf"                 "$DEST/system/etc/" 2>/dev/null

echo "=== Extracting vendor blobs ==="
cp "$STOCK_VENDOR/bin/hw/android.hardware.drm@1.0-service.widevine"   "$DEST/vendor/bin/hw/" 2>/dev/null
cp "$STOCK_VENDOR/bin/hw/android.hardware.gatekeeper@1.0-service"     "$DEST/vendor/bin/hw/" 2>/dev/null
cp "$STOCK_VENDOR/bin/hw/android.hardware.keymaster@3.0-service"      "$DEST/vendor/bin/hw/" 2>/dev/null
cp "$STOCK_VENDOR/bin/tee"                                            "$DEST/vendor/bin/" 2>/dev/null
cp "$STOCK_VENDOR/bin/tzdaemon"                                       "$DEST/vendor/bin/" 2>/dev/null
cp "$STOCK_VENDOR/bin/vndservicemanager"                              "$DEST/vendor/bin/" 2>/dev/null

cp "$STOCK_VENDOR/lib/libMcClient.so"                                 "$DEST/vendor/lib/" 2>/dev/null
cp "$STOCK_VENDOR/lib/libion_exynos.so"                               "$DEST/vendor/lib/" 2>/dev/null
cp "$STOCK_VENDOR/lib/libkeymaster2_mdfpp.so"                         "$DEST/vendor/lib/" 2>/dev/null
cp "$STOCK_VENDOR/lib/libkeymaster_helper.so"                         "$DEST/vendor/lib/" 2>/dev/null
cp "$STOCK_VENDOR/lib/libteecl.so"                                    "$DEST/vendor/lib/" 2>/dev/null
cp "$STOCK_VENDOR/lib/vendor.samsung.security.skeymaster@3.0_vendor.so" "$DEST/vendor/lib/" 2>/dev/null
cp "$STOCK_VENDOR/lib/hw/android.hardware.gatekeeper@1.0-impl.so"     "$DEST/vendor/lib/hw/" 2>/dev/null
cp "$STOCK_VENDOR/lib/hw/gatekeeper.exynos7870.so"                    "$DEST/vendor/lib/hw/" 2>/dev/null
cp "$STOCK_VENDOR/lib/hw/keystore.mdfpp.so"                           "$DEST/vendor/lib/hw/" 2>/dev/null
cp "$STOCK_VENDOR/lib/hw/vendor.samsung.security.skeymaster@3.0-impl.so" "$DEST/vendor/lib/hw/" 2>/dev/null

cp "$STOCK_VENDOR/app/mcRegistry/"*.tlbin                             "$DEST/vendor/app/mcRegistry/" 2>/dev/null
cp "$STOCK_VENDOR/app/mcRegistry/"*.drbin                             "$DEST/vendor/app/mcRegistry/" 2>/dev/null

cp "$STOCK_VENDOR/tee/"*                                              "$DEST/vendor/tee/" 2>/dev/null
mkdir -p "$DEST/vendor/tee/driver"
cp "$STOCK_VENDOR/tee/driver/"*                                       "$DEST/vendor/tee/driver/" 2>/dev/null

cp "$STOCK_VENDOR/compatibility_matrix.xml"                           "$DEST/vendor/" 2>/dev/null
cp "$STOCK_VENDOR/manifest.xml"                                       "$DEST/vendor/" 2>/dev/null

cp "$STOCK_VENDOR/etc/init/android.hardware.gatekeeper@1.0-service.rc" "$DEST/vendor/etc/init/" 2>/dev/null
cp "$STOCK_VENDOR/etc/init/android.hardware.keymaster@3.0-service.rc"  "$DEST/vendor/etc/init/" 2>/dev/null
cp "$STOCK_VENDOR/etc/init/vndservicemanager.rc"                       "$DEST/vendor/etc/init/" 2>/dev/null

echo "=== Done ==="
echo "Now extract prebuilt kernel and dtb from stock recovery.img:"
echo "  ./unpackimg.sh recovery.img"
echo "  cp split_img/recovery.img-kernel  prebuilt/Image"
echo "  cp split_img/recovery.img-dtb     prebuilt/dtb.img"
echo ""
echo "Also copy file_contexts from stock recovery ramdisk to recovery/root/prebuilt_file_contexts"
