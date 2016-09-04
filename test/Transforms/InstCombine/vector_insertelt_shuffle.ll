; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define<4 x float> @foo(<4 x float> %x) {
  %ins1 = insertelement<4 x float> %x, float 1.0, i32 1
  %ins2 = insertelement<4 x float> %ins1, float 2.0, i32 2
  ret<4 x float> %ins2
}

; FIXME: insertelements should fold to shuffle
; CHECK-LABEL: @foo
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 1.000000e+00, i32 1
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 2.000000e+00, i32 2
; CHECK-NEXT: ret <4 x float> %

define<4 x float> @bar(<4 x float> %x, float %a) {
  %ins1 = insertelement<4 x float> %x, float %a, i32 1
  %ins2 = insertelement<4 x float> %ins1, float 2.0, i32 2
  ret<4 x float> %ins2
}

; CHECK-LABEL: @bar
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float %{{.+}}, i32 1
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 2.000000e+00, i32 2
; CHECK-NEXT: ret <4 x float> %

define<4 x float> @baz(<4 x float> %x, i32 %a) {
  %ins1 = insertelement<4 x float> %x, float 1.0, i32 1
  %ins2 = insertelement<4 x float> %ins1, float 2.0, i32 %a
  ret<4 x float> %ins2
}

; CHECK-LABEL: @baz
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 1.000000e+00, i32 1
; CHECK-NEXT: insertelement <4 x float> %ins1, float 2.000000e+00, i32 %
; CHECK-NEXT: ret <4 x float> %

define<4 x float> @bazz(<4 x float> %x, i32 %a) {
  %ins1 = insertelement<4 x float> %x, float 1.0, i32 3
  %ins2 = insertelement<4 x float> %ins1, float 5.0, i32 %a
  %ins3 = insertelement<4 x float> %ins2, float 3.0, i32 2
  %ins4 = insertelement<4 x float> %ins3, float 1.0, i32 1
  %ins5 = insertelement<4 x float> %ins4, float 2.0, i32 2
  %ins6 = insertelement<4 x float> %ins5, float 7.0, i32 %a
  ret<4 x float> %ins6
}

; FIXME: insertelements should fold to shuffle
; CHECK-LABEL: @bazz
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 1.000000e+00, i32 3
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 5.000000e+00, i32 %
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 1.000000e+00, i32 1
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 2.000000e+00, i32 2
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 7.000000e+00, i32 %
; CHECK-NEXT: ret <4 x float> %

define<4 x float> @bazzz(<4 x float> %x) {
  %ins1 = insertelement<4 x float> %x, float 1.0, i32 5
  %ins2 = insertelement<4 x float> %ins1, float 2.0, i32 2
  ret<4 x float> %ins2
}

; CHECK-LABEL: @bazzz
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 2.000000e+00, i32 2
; CHECK-NEXT: ret <4 x float> %

define<4 x float> @bazzzz(<4 x float> %x) {
  %ins1 = insertelement<4 x float> %x, float 1.0, i32 undef
  %ins2 = insertelement<4 x float> %ins1, float 2.0, i32 2
  ret<4 x float> %ins2
}

; CHECK-LABEL: @bazzzz
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 1.000000e+00, i32 undef
; CHECK-NEXT: insertelement <4 x float> %{{.+}}, float 2.000000e+00, i32 2
; CHECK-NEXT: ret <4 x float> %
