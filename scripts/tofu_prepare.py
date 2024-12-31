import utils
import tofu_init
import tofu_plan


if __name__ == '__main__':
    config = utils.Config()

    tofu_init.run(config)
    tofu_plan.run(config)
