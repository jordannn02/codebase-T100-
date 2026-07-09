MAIN
    CALL input_sales_owner()
    CALL validate_order_owner()
END MAIN

FUNCTION input_sales_owner()
    DEFINE l_xmda002 LIKE xmda_t.xmda002
    DEFINE l_xmda003 LIKE xmda_t.xmda003

    LET l_xmda002 = "DEMO_SALES"
    LET l_xmda003 = "DEMO_DEPT"

    UPDATE xmda_t
       SET xmda002 = l_xmda002,
           xmda003 = l_xmda003
     WHERE xmdaent = 9999
       AND xmdadocno = "DEMO-SO-0001"
END FUNCTION

FUNCTION validate_order_owner()
    DEFINE l_count INTEGER

    SELECT COUNT(*)
      INTO l_count
      FROM xmda_t
     WHERE xmdaent = 9999
       AND xmdadocno = "DEMO-SO-0001"
       AND (xmda002 IS NULL OR xmda003 IS NULL)

    IF l_count > 0 THEN
        DISPLAY "owner or department is missing"
    END IF
END FUNCTION
