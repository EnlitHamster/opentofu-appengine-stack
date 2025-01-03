import utils
import tofu_plan_destroy
import tofu_apply_destroy


if __name__ == '__main__':
    config = utils.TofuFig()

    tofu_plan_destroy.run(config)
    tofu_apply_destroy.run(config)