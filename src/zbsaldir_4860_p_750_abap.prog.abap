*&---------------------------------------------------------------------*
*& Report ZBSALDIR_4860_P_750_ABAP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBSALDIR_4860_P_750_ABAP.

TYPES :BEGIN OF ty_first,
         werks  TYPE werks_d,
         arbpl  TYPE arbpl,
         toplam TYPE menge_d,
         meins  TYPE meins,
         islem  TYPE int8,
       END OF ty_first.

TYPES : tt_first TYPE TABLE OF ty_first WITH EMPTY KEY.

DATA(lt_first) = VALUE tt_first(
  ( werks = '2013' arbpl = '07' toplam = '16'   meins = '' )
  ( werks = '2013' arbpl = '07' toplam = '32'   meins = '' )
  ( werks = '2015' arbpl = '09' toplam = '07'   meins = '' ) ).


DATA(lt_second) = REDUCE tt_first( INIT sum = VALUE tt_first( ) FOR GROUPS grp OF ls_first IN lt_first
                                  GROUP BY ( werks = ls_first-werks
                                             arbpl = ls_first-arbpl )
                                  LET lv_meins = 'ADT'
                                  lv_no1 = 5
                                  lv_no2 = 3
                                  IN
                                  NEXT sum = VALUE tt_first( BASE sum ( werks = grp-werks
                                                                        arbpl = grp-arbpl
                                                                        toplam = REDUCE #( INIT lv_toplam TYPE ty_first-toplam
                                                                                           FOR ls_grp IN GROUP grp
                                                                                           NEXT lv_toplam = lv_toplam + ls_grp-toplam )
                                                                        meins = lv_meins
                                                                        islem = lv_no1 * lv_no2 ) ) ).

cl_demo_output=>display( lt_second ).
