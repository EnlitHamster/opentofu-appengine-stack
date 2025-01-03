import create_tofu_account
import init_app_engine
import init_project
import utils


if __name__ == '__main__':
    config = utils.ProjFig()

    init_project.run(config)
    create_tofu_account.run(config)
    init_app_engine.run(config)