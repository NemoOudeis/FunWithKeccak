.PHONY: clean All

All:
	@echo "----------Building project:[ crypto_pwc - Release ]----------"
	@$(MAKE) -f  "crypto_pwc.mk"
clean:
	@echo "----------Cleaning project:[ crypto_pwc - Release ]----------"
	@$(MAKE) -f  "crypto_pwc.mk" clean
