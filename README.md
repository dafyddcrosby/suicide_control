# chefdown

**Unsupported by Chef Software, Inc.**

The default recipe aborts a chef-client run if the correct entry exists in a
data bag, or has a specific tag (`chefdown_<bugid>`) set. This can be used to
prevent a daemonized chef-client from making changes on a system during ad-hoc
deployment, troubleshooting, or other purposes.

We use this cookbook at Chef internally. It is not externally supported.

The default recipe loads items for the node `chef_environment` from a data bag
`chefdown`. These must exist or it will raise an exception. The structure of
the items is:

    {
      "id": "_default",
      "chefdown": "none"
    }

Values for `chefdown` can be:

* none
* all
* daemonized

Optionally, nodes can be tagged with `chefdown_<bugid>` and the run will be
aborted.

    knife tag create NODENAME chefdown_45109

When done, remove the tag.

    knife tag delete NODENAME chefdown_45109

The benefit of using a bug ID in the tag means you can find out why chef was
turned off.

## Contributing

This cookbook is not externally supported by Chef. We use it
internally. We consider it code complete.
