import utils
import tofu_plan
import tofu_apply


if __name__ == '__main__':
    config = utils.Config()

    tofu_plan.run(config)
    tofu_apply.run(config)