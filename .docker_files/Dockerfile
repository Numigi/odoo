FROM odoo:11.0
MAINTAINER numigi <contact@numigi.com>

USER root

ENV ODOO_DIR /usr/lib/python3/dist-packages

RUN rm -rf ${ODOO_DIR}/odoo

COPY odoo ${ODOO_DIR}/odoo
COPY addons ${ODOO_DIR}/odoo-addons

RUN mv ${ODOO_DIR}/odoo/addons/* ${ODOO_DIR}/odoo-addons/ && \
    mv -f ${ODOO_DIR}/odoo-addons/* ${ODOO_DIR}/odoo/addons

# Install test requirements
COPY .docker_files/requirements.txt /
RUN pip3 install -r /requirements.txt && rm /requirements.txt

# File to run the tests with pytest-odoo
COPY .docker_files/run_pytest.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run_pytest.sh

# Configuration of the coverage report
COPY .docker_files/.coveragerc .

# Odoo configuration files
COPY .docker_files/main /mnt/extra-addons/main
COPY .docker_files/odoo.conf .docker_files/odoo_specific.conf /etc/odoo/

# required for pytest-odoo
ENV OPENERP_SERVER "${ODOO_RC}"

COPY .docker_files/extended_entrypoint.sh /
RUN chmod +x /extended_entrypoint.sh
ENTRYPOINT ["/extended_entrypoint.sh"]
CMD ["odoo"]
EXPOSE 8069 8071

USER odoo

