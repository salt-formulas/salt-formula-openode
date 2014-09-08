============
OPENODE
============

OPENode is open source web application for communities seeking answers for diverse problems in commercial, public or voluntary sectors. Based on flexible communication in nodes it helps to find solutions effectively and build smarter knowledgebase. It enables users to:

Ask questions and write answers
Discuss specific topics in linear forums
Group topics by tags
Index and search documents & images using OCR technology
Set public or private nodes and user rights.

Example pillar
------

.. code-block :: yaml

    openode:
      server:
        enabled: true
        workers: 3
        bind:
          address: 0.0.0.0
          port: 9753
        source:
          type: git
            address: https://github.com/openode/openode.git
            rev: master
        database:
          engine: 'postgresql'
          host: 'localhost'
          port: 5672
          name: 'openode'
          password: 'pass'
          user: 'openode'
      mayan:
        hmac_key: qweeAopi
        uri_id: asdsda
        port: 33333
        host: mayan.domain.com


Read More
------

* http://openode.net/
* http://openode.readthedocs.org/