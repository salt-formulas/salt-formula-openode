=======
OPENODE
=======

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
Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-openode/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-openode

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
